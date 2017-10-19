var = Faker::Name.first_name

FactoryGirl.define do
  factory :store do
    name var
    slug var.parameterize
  end
end
