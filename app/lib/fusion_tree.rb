class FusionTree
  class PickBucket
    def initialize
      @used = Hash.new {|h, k| h[k] = 0 }
    end

    def available?(account_hero)
      if account_hero.sharded?
        (account_hero.shards - @used[account_hero.id]) >= account_hero.max_shards
      else
        @used[account_hero.id] < 1
      end
    end

    def pick_one(account_hero)
      if account_hero.sharded?
        @used[account_hero.id] += account_hero.max_shards
      else
        @used[account_hero.id] += 1
      end
    end
  end

  class Group
    include Enumerable

    def initialize(tree, material)
      @tree = tree
      @material = material
      @heroes = []
      pick_heroes
    end

    def each(&block) ; @heroes.each(&block) ; end

  protected

    def pick_heroes
      find_matching_heroes
      pick_primary_source
      pick_matching_heroes
      fill_with_ex_marks
    end

    def add_hero(decorator, object)
      @heroes.push(FusionTree::Hero.new(decorator, object))
    end

    def find_matching_heroes
      if @material.material_hero
        @matches = @tree.account.account_heroes.where(hero_id: @material.material_hero.id).order('is_fodder desc, shards desc, level desc').to_a
      else
        @matches = @tree.account.account_heroes.joins(:hero)
        @matches = @matches.where('heroes.stars = ?', @material.stars) if @material.stars
        @matches = @matches.where('heroes.faction = ?', @material.faction) if @material.faction
        @matches = @matches.order('is_fodder desc, shards desc, level desc').to_a
      end
    end

    def pick_primary_source
      return unless @material.material_hero && (@material.material_hero.name == @material.hero.name)
      # the non-fodder non-sharded hero with the highest level (if we have one)
      # will become the fused hero; put it first on the list
      if i = @matches.find_index {|account_hero| !account_hero.fodder? && !account_hero.sharded? }
        @tree.bucket.pick_one(@matches[i])
        add_hero(:check_mark, @matches[i])
        @matches.delete_at(i)
      end
    end

    def pick_matching_heroes
      @matches.each do |account_hero|
        decorator = (account_hero.fodder? || account_hero.sharded?) ? :check_mark : :question_mark
        while @tree.bucket.available?(account_hero)
          @tree.bucket.pick_one(account_hero)
          add_hero(decorator, account_hero)
          return if @heroes.count >= @material.count
        end
        return if @heroes.count >= @material.count
      end
    end

    # FIXME RF split into 2 methods, "create object" and "while...add_hero"
    def fill_with_ex_marks
      if @material.material_hero
        object = @material.material_hero
      elsif shard_type = ShardType.find_by(stars: @material.stars, faction: @material.faction)
        object = shard_type
      elsif shard_type = ShardType.find_by(stars: @material.stars)
        # TODO create all needed ShardType, so this case never happens
        shard_type.faction = @material.faction
        object = shard_type
      else
        # FIXME should raise exception?
        Rails.logger.error("Material.generic_account_heroes got empty ShardType.find_by(stars=#{@material.stars}, faction=#{@material.faction})")
        return
      end
      while @heroes.count < @material.count
        add_hero(:ex_mark, object)
      end
    end
  end

  class Hero
    def initialize(decorator, object)
      @fusion_decorator = decorator
      @account_hero = object.is_a?(AccountHero) ? object : nil
      @target = object.is_a?(Hero) ? object : nil
    end

    def fusion_decorator ; @fusion_decorator ; end

    # TODO these should all come from AccountHero now
    def name ; target_attr(:name) ; end
    def stars ; target_attr(:stars) ; end
    def faction ; target_attr(:faction) ; end
    def role ; target_attr(:role) ; end
    def image_file ; target_attr(:image_file) ; end
    def asset_path ; target_attr(:asset_path) ; end
    def max_shards ; target_attr(:max_shards) ; end
    def generic? ; account_hero_attr(:generic?) ; end
    def hero ; account_hero_attr(:hero) ; end
    def target ; account_hero_attr(:target) ; end
    def level ; account_hero_attr(:level) ; end
    def leveled? ; account_hero_attr(:leveled?) ; end
    def shards ; account_hero_attr(:shards) ; end
    def sharded? ; account_hero_attr(:sharded?) ; end
    def max_sharded? ; account_hero_attr(:max_sharded?) ; end
    def fodder? ; account_hero_attr(:fodder?) ; end

  protected

    def account_hero_attr(key)
      @account_hero ? @account_hero.send(key) : nil
    end

    def target_attr(key)
      return @account_hero.send(key) if @account_hero
      return @target.send(key) if @target.respond_to?(key)
      nil
    end
  end

  include Enumerable

  def initialize(hero, account)
    @hero = hero
    @account = account
    @bucket = FusionTree::PickBucket.new
    @groups = @hero.sorted_materials.collect {|material| FusionTree::Group.new(self, material) }
  end

  def account ; @account ; end
  def bucket ; @bucket ; end
  def each(&block) ; @groups.each(&block) ; end
end
