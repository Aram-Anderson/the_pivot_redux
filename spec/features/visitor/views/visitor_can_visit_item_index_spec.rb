require 'rails_helper'

RSpec.describe "As a visitor" do
	it "from the root, visitor can visit items index and see all items" do
		store = create(:store)
		category = create(:category)
		@item_1 = create(:item, store: store, category: category)
		@item_2 = create(:item, store: store, category: category)

		visit store_items_path(store_slug: store.slug)

		expect(page).to have_content(@item_1.title)
		expect(page).to have_content(@item_1.price)
		expect(page).to have_content(@item_2.title)
		expect(page).to have_content(@item_2.price)

	end
end
