class Api::V1::Stores::MostRevenueController < ApplicationController
  def index
    render json: Store.highest_revenue
  end
end
