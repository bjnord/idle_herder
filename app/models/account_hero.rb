class AccountHero < ApplicationRecord
  belongs_to :account
  belongs_to :hero, optional: true

  validates :type, presence: true
  validates :level, presence: true
  validates :shards, presence: true

  scope :fodder, -> { where(is_fodder: true) }
  scope :wish_list, -> { where(level: 0, shards: 0).includes(:hero).order('heroes.stars desc, heroes.faction') }
  scope :stars_under_target, -> { where("type = 'SpecificAccountHero' and level > 0 and heroes.stars < target_stars").joins(:hero).order('target_stars desc, heroes.faction') }

  def initialize(*args)
    raise PureParentClassError if self.class == AccountHero
    super
  end

  before_validation do
    # form submission via controller evades our custom setter, so:
    self.shards = self[:shards]
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

  def faction_name
    Hero::faction_name_of(faction)
  end
end
