class MainController < ApplicationController
  def index
    @stores = Store.all
  end
end
