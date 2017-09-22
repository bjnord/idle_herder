FactoryGirl.define do
  factory :generic_account_hero do
    association  :account
    shards       { 1 + rand(20) }
    g_stars      { 3 + rand(3) }
    g_faction    { rand(Hero::FACTIONS.count) }

    factory :whole_generic_account_hero do
      shards  { 50 + rand(20) }
    end
  end
end
