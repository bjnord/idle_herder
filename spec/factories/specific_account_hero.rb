FactoryGirl.define do
  factory :specific_account_hero do
    association   :account
    association   :hero
    level         { 1 + rand(40) }
    shards        nil
    target_stars  { hero ? hero.stars : nil }

    factory :fusable_specific_account_hero do
      association   :hero, factory: :fusable_hero
      target_stars  { hero.stars + 1 }
    end

    factory :sharded_specific_account_hero do
      association  :hero, factory: :shardable_hero
      level        nil
      shards       { 1 + rand(20) }
    end

    factory :wish_list_account_hero do
      level      nil
      wish_list  true
    end
  end
end
