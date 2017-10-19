class Store < ApplicationRecord
  has_many :items
  has_many :user_roles
  has_many :users, through: :user_roles
end
