class AccountHero < ApplicationRecord
  belongs_to :account
  belongs_to :hero, optional: true
  belongs_to :shard_type, optional: true

  validate :hero_or_shard_type_present
  validate :hero_and_shard_type_not_both_present
  validate :level_and_shards_not_both_present
  validate :shard_type_has_shards_and_not_level

protected

  def hero_or_shard_type_present
    if self.hero.blank? && self.shard_type.blank?
      # FIXME use locale string
      errors.add(:base, 'Either hero or shard_type is required')
    end
  end

  def hero_and_shard_type_not_both_present
    if !self.hero.blank? && !self.shard_type.blank?
      # FIXME use locale string
      errors.add(:base, 'Using both hero and shard_type is invalid')
    end
  end

  def level_and_shards_not_both_present
    if !self.level.blank? && !self.shards.blank?
      # FIXME use locale string
      errors.add(:base, 'Using both level and shards is invalid')
    end
  end

  def shard_type_has_shards_and_not_level
    if !self.shard_type.blank?
      if self.shards.blank?
        errors.add(:shards, :missing)
      elsif !self.level.blank?
        errors.add(:level, :invalid)
      end
    end
  end
end
