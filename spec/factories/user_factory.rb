FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.two_word_name }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password}
  end
end