class Api::V1::Items::MostPopularController < ApplicationController
  def index
    render json: Item.most_popular
  end


end
