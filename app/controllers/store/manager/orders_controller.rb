class Store::Manager::OrdersController < ApplicationController
  def index
    if params[:status] == "ordered" || params[:status] == "paid" || params[:status] == "cancelled" || params[:status] == "completed"
      @orders = Order.find(OrderItem.where(item_id: Store.find_by_slug(params[:store_slug]).items.ids).pluck(:order_id)).filter_by_status(params[:status])
    else

      @orders = Order.find(OrderItem.where(item_id: Store.find_by_slug(params[:store_slug]).items.ids).pluck(:order_id))
    end
    @store = Store.find_by_slug(params[:store_slug])


  end



  	def show
  		@order = Order.find(params[:id])
  		unless current_user.id == @order.user_id
  			redirect_to dashboard_index_path
  		end
  	end

  	def update
  		@order = Order.find(params[:id])
  		@order.update(status: params[:status])
  		@order.save
  		redirect_back(fallback_location: root_path)
  	end


  	def new
  		order = Order.create(status: "ordered", user_id: current_user.id)
  		item_hash = @cart.item_and_quantity
  		order.add(item_hash)
  		@cart.destroy
  		flash[:success] = "Order was successfully placed"
  		redirect_to orders_path
  	end


end
