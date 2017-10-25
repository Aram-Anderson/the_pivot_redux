class Api::V1::StoresController < ApplicationController
  def index
    render json: Store.all, status: 200
  end

  def show
    render json: Store.find(params[:id]), status: 200
  end

  def create
    render json: Store.create(store_params), status: 201
  end

  def update
    render json: Store.update(params[:id], store_params), status: 200
  end

  def destroy
    render json: Store.delete(params[:id]), status: 204
  end

  private

    def store_params
      params.require(:store).permit(:name, :slug)
    end

end
