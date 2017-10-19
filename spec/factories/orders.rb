FactoryGirl.define do
  factory :order do
    status 1
    association :user
    association :store
  end
end
