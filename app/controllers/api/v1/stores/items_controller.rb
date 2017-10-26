class Api::V1::Stores::ItemsController < ApplicationController
  def index
    render json: Store.find(params[:id]).items
  end
end
