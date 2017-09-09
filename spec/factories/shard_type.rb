FactoryGirl.define do
  factory :shard_type do
    id       { 1 + rand(12) }
    stars    { 3 + rand(2) }
  end
end
