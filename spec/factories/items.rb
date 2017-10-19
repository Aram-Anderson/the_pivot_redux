FactoryGirl.define do
  factory :item do
    title { Faker::Name.first_name }
    description "Some thing to do stuff with"
    price 8.99
    image nil
    association :category
  end
end
