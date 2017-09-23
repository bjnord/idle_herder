FactoryGirl.define do
  factory :generic_hero do
    transient do
      h_stars       { 3 + rand(4) }
      h_factioned   { (h_stars == 3) ? false : (rand(3) < 2) }
      h_faction     { h_factioned ? rand(Hero::FACTIONS.count) : nil }
    end

    stars            { h_stars }
    faction          { h_faction }

    factory :generic_nine_star_hero do
      stars    9
      faction  nil
    end
  end
end
