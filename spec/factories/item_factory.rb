FactoryGirl.define do
  factory :item do
    description { Faker::Lorem.words(3).join(' ') }
  end
end
