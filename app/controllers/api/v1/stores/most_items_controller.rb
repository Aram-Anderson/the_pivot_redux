class Api::V1::Stores::MostItemsController < ApplicationController
  def index
    render json: Store.most_items(params[:quantity])
  end
end
