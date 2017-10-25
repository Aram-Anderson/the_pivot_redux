class CategoriesController < ApplicationController
	def show
			@category = Category.find_by(params[:slug])
	end
end
