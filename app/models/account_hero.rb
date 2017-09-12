class AccountHero < ApplicationRecord
  belongs_to :account
  belongs_to :hero, optional: true
  belongs_to :shard_type, optional: true

  validates :level, presence: true
  validates :shards, presence: true
  validate :hero_or_shard_type_present
  validate :hero_and_shard_type_not_both_present
  validate :level_and_shards_not_both_present
  validate :shard_type_has_shards_and_not_level

protected

  def hero_or_shard_type_present
    unless self.hero || self.shard_type
      # FIXME use locale string
      errors.add(:base, 'Either hero or shard_type is required')
    end
  end

  def hero_and_shard_type_not_both_present
    if self.hero && self.shard_type
      # FIXME use locale string
      errors.add(:base, 'Using both hero and shard_type is invalid')
    end
  end

  def level_and_shards_not_both_present
    if (self.level && (self.level > 0)) && (self.shards && (self.shards > 0))
      # FIXME use locale string
      errors.add(:base, 'Using both level and shards is invalid')
    end
  end

  def shard_type_has_shards_and_not_level
    if self.shard_type
      unless self.shards && (self.shards > 0)
        errors.add(:shards, :missing)
      end
      if self.level && (self.level > 0)
        errors.add(:level, :invalid)
      end
    end
  end
end
