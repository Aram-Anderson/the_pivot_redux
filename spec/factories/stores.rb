var = Faker::Name.first_name

FactoryGirl.define do
  factory :store do
    sequence :name do |n|
      "#{n}MyStore"
    end
    sequence :slug do |x|
      "#{x}-my-store"
    end
  end
end
