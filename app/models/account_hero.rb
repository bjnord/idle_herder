class AccountHero < ApplicationRecord
  belongs_to :account
  belongs_to :hero, optional: true
  belongs_to :shard_type, optional: true

  attr_writer :wish_list

  validates :level, presence: true
  validates :shards, presence: true
  validate :hero_or_shard_type_present
  validate :hero_and_shard_type_not_both_present
  validate :level_is_within_maximum
  validate :level_or_shards_present_unless_wish_list
  validate :level_and_shards_not_both_present
  validate :shard_type_has_shards_and_not_level

  # form submission via controller evades our custom setters, so:
  before_validation do
    self.level = self[:level]
    self.shards = self[:shards]
  end

  def level=(value)
    super(value || 0)
  end

  def shards=(value)
    super(value || 0)
  end

  # NB don't mix these two! <https://goo.gl/pNYdjZ>
  #    the method is for Rails code (derived value)
  #    the accessor is for the form checkbox (independent value, normalized)
  def wish_list?
    (!level || (level < 1)) && (!shards || (shards < 1))
  end
  def wish_list
    (@wish_list.blank? || (@wish_list == 0)) ? nil : '1'
  end

protected

  def hero_or_shard_type_present
    unless hero || shard_type
      # FIXME use locale string
      errors.add(:base, 'Either hero or shard_type is required')
    end
  end

  def hero_and_shard_type_not_both_present
    if hero && shard_type
      # FIXME use locale string
      errors.add(:base, 'Using both hero and shard_type is invalid')
    end
  end

  def level_is_within_maximum
    if hero && (level > hero.max_level)
      # FIXME use locale string
      $stderr.puts "hero=#{hero.inspect} self=#{self.inspect}"
      errors.add(:level, 'is greater than maximum')
    end
  end

  def level_or_shards_present_unless_wish_list
    unless wish_list
      if (level < 1) && (shards < 1)
        # FIXME use locale string
        errors.add(:base, 'Either level or shards is required')
      end
    end
  end

  def level_and_shards_not_both_present
    if (level > 0) && (shards > 0)
      # FIXME use locale string
      errors.add(:base, 'Using both level and shards is invalid')
    end
  end

  def shard_type_has_shards_and_not_level
    if shard_type
      unless shards > 0
        errors.add(:shards, :missing)
      end
      if level > 0
        errors.add(:level, :invalid)
      end
    end
  end
end
