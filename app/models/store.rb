class Store < ApplicationRecord
  has_many :items
  has_many :user_roles
  has_many :users, through: :user_roles

  has_many :store_orders
  has_many :orders, through: :store_orders


  def self.highest_revenue
    select("stores.*, sum(items.price * order_items.quantity) AS revenue")
    .joins(items: [:order_items, :orders])
    .merge(Order.completed)
    .group(:id)
    .order('revenue DESC')
    .limit(10)
  end

end
