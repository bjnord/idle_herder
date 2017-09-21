class AccountHero < ApplicationRecord
  belongs_to :account
  belongs_to :hero, optional: true
  belongs_to :shard_type, optional: true

  attr_writer :wish_list

  validates :level, presence: true
  validates :shards, presence: true
  validates :target_stars, presence: true
  validates :target_stars, numericality: { only_integer: true, greater_than: 0 }, unless: Proc.new {|ah| ah.target_stars.blank? }
  validate :hero_or_shard_type_present
  validate :hero_and_shard_type_not_both_present
  validate :level_is_within_maximum
  validate :shards_valid_for_this_hero
  validate :level_or_shards_present_unless_wish_list
  validate :level_and_shards_not_both_present
  validate :shard_type_has_shards_and_not_level
  validate :target_stars_is_within_limits

  scope :fodder, -> { where(is_fodder: true) }
  scope :wish_list, -> { where(level: 0, shards: 0).includes(:hero).order('heroes.stars desc, heroes.faction') }
  scope :stars_under_target, -> { where('level > 0 and heroes.stars < target_stars').joins(:hero).order('target_stars desc, heroes.faction') }

  before_validation do
    # form submission via controller evades our custom setters, so:
    self.level = self[:level]
    self.shards = self[:shards]
    # force target_stars value for shards/shard_type heroes:
    if target && (shard_type || sharded?)
      self.target_stars = target.stars
    end
  end

  def level=(value)
    super(value || 0)
  end
  def leveled?
    level && (level > 0)
  end

  def shards=(value)
    super(value || 0)
  end
  def sharded?
    shards && (shards > 0)
  end

  def fodder?
    is_fodder
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

  def target
    hero || shard_type
  end

protected

  def hero_or_shard_type_present
    unless hero || shard_type
      errors.add(:base, :hero_or_shard_type_required)
    end
  end

  def hero_and_shard_type_not_both_present
    if hero && shard_type
      errors.add(:base, :hero_and_shard_type_together_invalid)
    end
  end

  def level_is_within_maximum
    if hero && (level > hero.max_level)
      errors.add(:level, :cannot_exceed_for_this_hero, maximum: hero.max_level)
    end
  end

  def shards_valid_for_this_hero
    if hero && sharded? && !hero.max_shards
      errors.add(:shards, :invalid_for_this_hero)
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

  def shard_type_has_shards_and_not_level
    if shard_type
      unless sharded?
        errors.add(:shards, :missing)
      end
      if leveled?
        errors.add(:level, :invalid)
      end
    end
  end

  def target_stars_is_within_limits
    return if !target
    if target_stars < target.stars
      errors.add(:target_stars, :must_be_at_least_for_this_hero, minimum: target.stars)
    elsif target_stars > target.max_stars
      errors.add(:target_stars, :cannot_exceed_for_this_hero, maximum: target.max_stars)
    end
  end
end
