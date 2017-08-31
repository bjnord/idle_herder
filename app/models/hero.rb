class Hero < ApplicationRecord
  self.primary_key = 'id'

  FACTIONS = ['Forest', 'Shadow', 'Fortress', 'Abyss', 'Dark', 'Light']
  ROLES = ['Warrior', 'Mage', 'Ranger', 'Assassin', 'Priest']

  validates :name, presence: true
  validates :stars, presence: true
  validates :stars, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }, unless: Proc.new {|h| h.stars.blank? }
  validates :faction, presence: true
  validates :faction, inclusion: {in: FACTIONS, message: 'is not valid'}, unless: Proc.new {|h| h.faction.blank? }
  validates :role, presence: true
  validates :role, inclusion: {in: ROLES, message: 'is not valid'}, unless: Proc.new {|h| h.role.blank? }

  def self.build_from_json(id)
    json = File.read(self.json_path(id))
    hero_h = JSON.parse(json)
    hero_h['image_file'] = hero_h.delete('img')
    Hero.new(hero_h.except('img_src', 'fuses_into', 'fused_from', 'sources'))
  end

protected

  def self.json_path(id)
    Rails.root.join('db', 'data', 'heroes', "#{id}.json")
  end
end
