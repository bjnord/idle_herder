class Hero < ApplicationRecord
  self.primary_key = 'id'

  has_many :materials, inverse_of: :hero, dependent: :destroy
  accepts_nested_attributes_for :materials

  MAX_STARS = 10
  MAX_LEVELS = {10 => 250, 9 => 200, 8 => 180, 7 => 160, 6 => 140, 5 => 100, 4 => 80, 3 => 60, 2 => 50, 1 => 40}
  FACTIONS = ['Shadow', 'Fortress', 'Abyss', 'Forest', 'Dark', 'Light']
  ROLES = ['Warrior', 'Mage', 'Ranger', 'Assassin', 'Priest']

  validates :id, presence: true
  validates :id, numericality: { only_integer: true, greater_than: 0 }, unless: Proc.new {|h| h.id.blank? }
  validates :name, presence: true
  validates :stars, presence: true
  validates :stars, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: MAX_STARS }, unless: Proc.new {|h| h.stars.blank? }
  validates :faction, presence: true
  validates :faction, inclusion: {in: (0..FACTIONS.count-1), message: 'is not valid'}, unless: Proc.new {|h| h.faction.blank? }
  validates :role, presence: true
  validates :role, inclusion: {in: ROLES, message: 'is not valid'}, unless: Proc.new {|h| h.role.blank? }

  def faction=(faction)
    super(faction.respond_to?(:to_str) ? FACTIONS.index(faction) : faction)
  end
  def faction_name
    self.faction.nil? ? nil : FACTIONS[self.faction]
  end
  def self.faction_name_of(faction)
    faction.nil? ? nil : FACTIONS[faction]
  end

  def max_level
    MAX_LEVELS[stars]
  end

  def self.build_from_json(id)
    json = File.read(self.json_path(id))
    hero_h = JSON.parse(json)
    hero_h['image_file'] = hero_h.delete('img')
    hero = Hero.new(hero_h.except('img_src', 'fuses_into', 'fused_from', 'sources'))
    if hero_h['fused_from']
      hero.materials_attributes = hero_h['fused_from'].collect do |ff|
        Material::attr_from_hash(ff)
      end.reject {|m| m.blank? }
    end
    hero
  end

  def update_materials!(new_materials)
    new_materials.each do |material|
      match = self.materials.select do |m|
        # FIXME more elegant way to compare-except-id?
        (m.count == material.count) &&
          (m.material_hero_id == material.material_hero_id) &&
          (m.stars == material.stars) &&
          (m.faction == material.faction)
      end
      if match.empty?
        self.materials << material
      end
    end
    self.save! if self.changed?
    true
  end

  def material_of
    @material_of ||= Material.where(material_hero_id: self.id).includes(:hero).order('heroes.stars desc', 'heroes.name').collect {|m| m.hero }
  end

  def other_stars
    @other_stars ||= Hero.where(name: self.name).where.not(stars: self.stars).order('stars desc')
  end

protected

  def self.json_path(id)
    Rails.root.join('db', 'data', 'heroes', "#{id}.json")
  end
end
