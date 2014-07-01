FactoryGirl.define do
  factory :item do
    content { Faker::HipsterIpsum.words(3).join(' ') }
  end
end
