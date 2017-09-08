FactoryGirl.define do
  factory :account do
    association  :user
    player_name  { Faker::Name.first_name }
  end
end
