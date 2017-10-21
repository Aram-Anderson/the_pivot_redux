class Store::Manager::DashboardController < ApplicationController
  def index
    @store = Store.first
  end
end
