FactoryBot.define do
  factory :order do
    status 1
    association :user
  end
end
