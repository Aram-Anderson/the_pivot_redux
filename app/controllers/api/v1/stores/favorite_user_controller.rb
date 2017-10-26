class Api::V1::Stores::FavoriteUserController < ApplicationController
  def show
    render json: Store.find(params[:id]).favorite_user
  end
end
