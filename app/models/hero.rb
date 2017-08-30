class Hero < ApplicationRecord
  validates :name, presence: true
  validates :stars, presence: true
  validates :stars, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }, unless: Proc.new {|h| h.stars.blank? }
  validates :faction, presence: true
  validates :faction, inclusion: {in: ['Forest', 'Shadow', 'Fortress', 'Abyss', 'Light', 'Dark'], message: 'is not valid'}, unless: Proc.new {|h| h.faction.blank? }
  validates :class, presence: true
  validates :class, inclusion: {in: ['Warrior', 'Mage', 'Assassin', 'Ranger', 'Priest'], message: 'is not valid'}, unless: Proc.new {|h| h.class.blank? }
end
