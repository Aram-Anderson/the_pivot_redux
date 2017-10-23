class Store::ItemsController < ApplicationController
	def index
		@store = Store.find_by_slug(params["store_slug"])
		@items = Store.find_by_slug(params["store_slug"]).items
	end

	def show
		@item = Item.find(params[:id])
	end
end
