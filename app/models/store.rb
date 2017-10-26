class Store < ApplicationRecord
  has_many :items
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :store_orders
  has_many :orders, through: :store_orders
end
