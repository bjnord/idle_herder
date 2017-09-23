class GenericHero
  attr_accessor :stars
  attr_reader :faction

  def initialize(stars = nil, faction = nil)
    @stars = stars
    @faction = faction
  end

  def generic? ; true ; end
  def name ; "#{faction_name} hero".strip ; end

  def max_stars
    stars
  end
  def max_shards
    Hero::MAX_SHARDS[stars]
  end

  def faction=(faction)
    if faction.respond_to?(:to_str)
      faction = Hero::FACTIONS.index(faction)
    end
    @faction = faction
  end
  def faction_name
    self.faction ? Hero::FACTIONS[self.faction] : 'Any'
  end

  def asset_path
    # FIXME create these missing icons
    if stars > 4
      return "generics/5-Any.png"
    end
    "generics/#{stars}-#{faction_name}"
  end

  def valid?
    if !@stars || (@stars < 3) || ((@stars > 6) && (@stars != 9))
      false
    elsif @faction && ((@stars == 3) || (@stars == 9))
      false
    else
      true
    end
  end
end
