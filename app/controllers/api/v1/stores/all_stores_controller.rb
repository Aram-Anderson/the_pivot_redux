class Api::V1::Stores::AllStoresController < ApplicationController

  def index
    render json: Store.all
  end

  def update

  end
end
