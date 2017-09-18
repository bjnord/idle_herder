FactoryGirl.define do
  factory :hero do
    transient do
      h_stars     { 1 + rand(10) }
      h_natural   { (h_stars < 5 || h_stars == 10) ? false : ((rand(2) == 1) ? true : false) }
      h_max_stars { (h_stars < 4 || h_stars == 10) ? h_stars : ((h_stars == 4) ? 5 : (h_natural ? 10 : 9)) }
    end

    id         { 1 + rand(400) }
    name       { 'Mighty ' + Faker::Name.first_name }
    role       { Hero::ROLES[rand(Hero::ROLES.count)] }
    faction    { rand(Hero::FACTIONS.count) }
    stars      { h_stars }
    natural    { h_natural }
    max_stars  { h_max_stars }

    factory :five_star_hero do
      stars      5
      natural    false
      max_stars  5
    end

    factory :ten_star_hero do
      stars      10
      natural    false
      max_stars  10
    end

    factory :shardable_hero do
      stars      { 3 + rand(3) }
      natural    false
      max_stars  { (stars == 4) ? 5 : stars }
    end
  end
end
