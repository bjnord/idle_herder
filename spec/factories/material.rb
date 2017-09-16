FactoryGirl.define do
  factory :material do
    association  :hero
    count        { 2 + rand(3) }
    stars        { 4 + rand(3) }
    faction      { rand(6) }
  end
end
