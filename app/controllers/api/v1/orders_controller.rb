class Api::V1::OrdersController < ApplicationController
  def index
    render json: Order.all, status: 200
  end

  def show
    render json: Order.find(params[:id]), status: 200
  end

  def create
    render json: Order.create(order_params), status: 201
  end

  def update
    render json: Order.update(params[:id], order_params), status: 200
  end

  def destroy
    render json: Order.delete(params[:id]), status: 204
  end

  private

    def order_params
      params.require(:order).permit(:status, :user_id)
    end

end
