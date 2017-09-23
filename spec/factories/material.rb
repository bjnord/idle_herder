FactoryGirl.define do
  factory :material do
    association  :hero
    association  :material_hero, factory: :shardable_hero
    count        { 2 + rand(3) }

    factory :generic_material do
      material_hero  nil
      stars          { 4 + rand(3) }
      faction        { rand(Hero::FACTIONS.count) }
    end
  end
end
