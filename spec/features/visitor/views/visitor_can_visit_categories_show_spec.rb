require 'rails_helper'
RSpec.describe "As a visitor can visit category show page" do
	it " can visit category show page" do
		store = create(:store)
		category = create(:category)
		item = create(:item, store: store, category: category)

		visit category_path(category)

	end
end
