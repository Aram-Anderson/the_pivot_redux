class Store::Manager::Dashboard::ItemsController < ApplicationController
  def index
    @items = Store.find_by_slug(params["store_slug"]).items
  end
end
