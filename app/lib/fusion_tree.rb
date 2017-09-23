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

    def fill_with_ex_marks
      object = @material.material_hero || GenericHero.new(@material.stars, @material.faction)
      while @heroes.count < @material.count
        add_hero(:ex_mark, object)
      end
    end
  end

  class Hero
    def initialize(fusion_decorator, object)
      @fusion_decorator = fusion_decorator
      @object = object
    end

    def fusion_decorator ; @fusion_decorator ; end

    # delegate attributes to our object (name, stars, faction, etc.)
    # NOTE do NOT allow assignment, only read
    def method_missing(symbol, *args, &block)
      if @object && (symbol.to_s !~ /=/)
        @object.send(symbol, *args, &block)
      else
        super(symbol, *args, &block)
      end
    end
    def respond_to?(symbol, *args)
      if @object && (symbol.to_s !~ /=/)
         @object.respond_to?(symbol, *args)
      else
        super(symbol, *args)
      end
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
