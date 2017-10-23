class Store::Manager::OrdersController < ApplicationController
  def index
    @orders = Order.find(OrderItem.where(item_id: Store.find_by_slug(params[:store_slug]).items.ids).pluck(:order_id))
  end
end
