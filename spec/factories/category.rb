var =  Faker::Hacker.unique.verb 

FactoryGirl.define do
  factory :category do
    title var
    slug var.parameterize
  end
end
