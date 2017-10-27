class Api::V1::Stores::AllStoresController < ApplicationController

  def index
    if params[:api_key] == ENV["API_KEY"]
      render json: Store.all
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def update
    if params[:api_key] == ENV["API_KEY"]
      render json: Store.where(status: params[:status])
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
