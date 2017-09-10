FactoryGirl.define do
  factory :material do
    association  :hero
    count        { 2 + rand(3) }
    stars        { 4 + rand(2) }
    faction      { 1 + rand(6) }
  end
end
