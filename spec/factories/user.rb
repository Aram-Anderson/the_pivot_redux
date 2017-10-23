FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    address { Faker::Address.street_address }
    phone {Faker::PhoneNumber.phone_number}
  end
end
