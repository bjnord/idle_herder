class Material < ApplicationRecord
  belongs_to :hero, inverse_of: :materials
  belongs_to :material_hero, optional: true, class_name: 'Hero', foreign_key: :material_hero_id
  validates :count, presence: true
  validates :count, numericality: { only_integer: true, greater_than: 0 }, unless: Proc.new {|m| m.count.blank? }
  validates :stars, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }, unless: Proc.new {|m| m.stars.blank? }
  validates :faction, inclusion: {in: (0..Hero::FACTIONS.count-1), message: 'is not valid'}, unless: Proc.new {|m| m.faction.blank? }
  validate :target_present

  def faction=(faction)
    super(faction.respond_to?(:to_str) ? Hero::FACTIONS.index(faction) : faction)
  end
  def faction_name
    self.faction.nil? ? nil : Hero::FACTIONS[self.faction]
  end

  def self.attr_from_hash(material_h)
    return {} if material_h['count'].blank?
    if material_h['name']
      if hero = Hero.find_by_name_and_stars(material_h['name'], material_h['stars'])
        {count: material_h['count'], material_hero_id: hero.id, stars: hero.stars}
      else
        {}
      end
    elsif material_h['stars'] || material_h['faction']
      {count: material_h['count'], faction: material_h['faction'], stars: material_h['stars']}
    else
      {}
    end
  end

protected

  def target_present
    if self.material_hero_id.blank? && self.stars.blank? && self.faction.blank?
      errors.add(:base, 'Material target cannot be blank')
    end
  end
end
