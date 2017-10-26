class Store::Manager::OrdersController < ApplicationController
  def index
    @store = Store.find_by_slug(params[:store_slug])
    if params[:status] == "ordered" || params[:status] == "paid" || params[:status] == "cancelled" || params[:status] == "completed"
      @orders = @store.orders.where(status: params[:status])
    else
      @orders = @store.orders
    end
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
