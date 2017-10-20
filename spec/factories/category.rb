FactoryGirl.define do
  factory :category do
    sequence :title do |n|
      "#{n}stuff"
    end
    sequence :slug do |n|
      "#{n}things"
    end
  end
end
