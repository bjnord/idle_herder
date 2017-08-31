class Hero < ApplicationRecord
  FACTIONS = ['Forest', 'Shadow', 'Fortress', 'Abyss', 'Dark', 'Light']
  CLASSES = ['Warrior', 'Mage', 'Ranger', 'Assassin', 'Priest']

  validates :name, presence: true
  validates :stars, presence: true
  validates :stars, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }, unless: Proc.new {|h| h.stars.blank? }
  validates :faction, presence: true
  validates :faction, inclusion: {in: FACTIONS, message: 'is not valid'}, unless: Proc.new {|h| h.faction.blank? }
  validates :class, presence: true
  validates :class, inclusion: {in: CLASSES, message: 'is not valid'}, unless: Proc.new {|h| h.class.blank? }
end
