class Store::AdminController < ApplicationController
  def index
    @store = Store.find_by(slug: params[:store_slug])
  end
end
