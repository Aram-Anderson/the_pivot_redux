require 'rails_helper'

RSpec.describe "As a visitor" do
	it "from the item index, visitor can visit an item's show page" do

		store = create(:store)
		category = create(:category)
		@item_1 = create(:item, store: store, category: category)
		@item_2 = create(:item, store: store, category: category)

		visit store_items_path(store_slug: store.slug)

		click_on @item_1.title

		expect(page).to have_content(@item_1.title)
		expect(page).to have_content(@item_1.description)
		expect(page).to have_content(@item_1.price)
		expect(page).to have_content("Shop")

		visit store_items_path(store_slug: store.slug)

		click_on @item_2.title

		expect(page).to have_content
		expect(page).to have_content(@item_2.title)
		expect(page).to have_content(@item_2.description)
		expect(page).to have_content(@item_2.price)

	end
end
