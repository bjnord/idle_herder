FactoryGirl.define do
  factory :user do
    email        { Faker::Internet.email }
    password     { Faker::Internet.password }
    role         "user"
    confirmed_at Time.now
  end

  factory :admin_user, class: User do
    email        { Faker::Internet.email }
    password     { Faker::Internet.password }
    role         "admin"
    confirmed_at Time.now
  end
end
