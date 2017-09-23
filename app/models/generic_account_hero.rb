class GenericAccountHero < AccountHero
  validates :g_stars, presence: true
  validates :g_stars, numericality: { only_integer: true, greater_than_or_equal_to: 3, less_than_or_equal_to: 5 }, unless: Proc.new {|h| h.g_stars.blank? }
  validates :g_faction, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: Hero::FACTIONS.count }, unless: Proc.new {|h| h.g_faction.blank? }
  validates :shards, numericality: { only_integer: true, greater_than: 0 }

  validate :level_not_present, if: :level

  before_validation do
    # force is_fodder and target_stars values for generic heroes:
    self.is_fodder = true
    self.target_stars = g_stars if g_stars
  end

  # overrides: always the case for generic heroes:
  def specific? ; false ; end
  def understarred? ; false ; end
  def wish_list? ; false ; end
  def is_fodder ; true ; end
  def natural? ; false ; end

  # equivalents for SpecificAccountHero -> Hero delegation
  def name ; "#{faction_name} hero".strip ; end
  def stars ; g_stars ; end
  def max_stars ; g_stars ; end
  def target_stars ; g_stars ; end
  def faction ; g_faction ; end
  def max_shards ; Hero::MAX_SHARDS[g_stars] ; end

  def faction_name
    g_faction ? Hero::faction_name_of(g_faction) : 'Any'
  end

  def asset_path
    "generics/#{stars}-#{faction_name}.png"
  end

protected

  def level_not_present
    if level > 0
      errors.add(:level, :invalid_for_this_hero)
    end
  end
end
