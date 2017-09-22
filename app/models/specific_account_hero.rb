class SpecificAccountHero < AccountHero
  attr_writer :wish_list

  validates :hero, presence: true
  validates :target_stars, presence: true
  validates :target_stars, numericality: { only_integer: true, greater_than: 0 }, if: :target_stars
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :shards, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :level_is_within_maximum, if: :hero
  validate :level_or_shards_present_unless_wish_list
  validate :level_and_shards_not_both_present
  validate :shards_valid_for_this_hero, if: Proc.new {|ah| ah.sharded? && ah.hero }
  validate :target_stars_is_within_limits, if: Proc.new {|ah| ah.target_stars && ah.hero }

  before_validation do
    # form submission via controller evades our custom setter, so:
    self.level = self[:level]
    # force target_stars value for sharded heroes:
    if hero && sharded?
      self.target_stars = hero.stars
    end
    # force is_fodder value for low-level heroes:
    if hero && (hero.stars <= 3)
      self.is_fodder = true
    end
  end

  def level=(value)
    super(value || 0)
  end
  def leveled?
    level && (level > 0)
  end

  # NB don't mix these two! <https://goo.gl/pNYdjZ>
  #    the method is for Rails code (derived value)
  #    the accessor is for the form checkbox (independent value, normalized)
  def wish_list?
    !leveled? && !sharded?
  end
  def wish_list
    (@wish_list.blank? || (@wish_list == 0)) ? nil : '1'
  end

  def understarred? ; hero && (hero.stars < target_stars) ; end

  # this gives us Hero attributes directly (name, stars, faction, etc.)
  # NOTE do NOT allow assignment, only read
  def method_missing(symbol, *args, &block)
    if hero && (symbol.to_s !~ /=/)
      hero.send(symbol, *args, &block)
    else
      super(symbol, *args, &block)
    end
  end
  def respond_to?(symbol, *args)
    if hero && (symbol.to_s !~ /=/)
      hero.respond_to?(symbol, *args)
    else
      super(symbol, *args)
    end
  end

protected

  def level_is_within_maximum
    if level > hero.max_level
      errors.add(:level, :cannot_exceed_for_this_hero, maximum: hero.max_level)
    end
  end

  def level_or_shards_present_unless_wish_list
    if !leveled? && !sharded?
      errors.add(:base, :level_or_shards_required) unless wish_list
    end
  end

  def level_and_shards_not_both_present
    if leveled? && sharded?
      errors.add(:base, :level_and_shards_together_invalid)
    end
  end

  def shards_valid_for_this_hero
    if !max_shards
      errors.add(:shards, :invalid_for_this_hero)
    end
  end

  def target_stars_is_within_limits
    if target_stars < hero.stars
      errors.add(:target_stars, :must_be_at_least_for_this_hero, minimum: hero.stars)
    elsif target_stars > hero.max_stars
      errors.add(:target_stars, :cannot_exceed_for_this_hero, maximum: hero.max_stars)
    end
  end
end
