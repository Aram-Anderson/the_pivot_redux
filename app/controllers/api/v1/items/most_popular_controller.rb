class Api::V1::Items::MostPopularController < ApplicationController
  def index
    if params[:api_key] == ENV["API_KEY"]
      render json: Item.most_popular
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
