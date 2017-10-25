require 'rails_helper'

RSpec.feature "Removing an item from my cart" do
  describe "When a visitor is viewing their cart" do
    it "they can remove an item" do
      store = create(:store)
      category = create(:category)
      @item = create(:item, store: store, category: category)

      visit store_items_path(store_slug: store.slug)

      click_on "Add to cart"

      click_on "Add to cart"

      click_on "Cart"

      expect(page).to have_link("Remove")

      click_on "Remove"

      expect(current_path).to eq(carts_path)
      expect(page).to have_content("Successfully removed #{@item.title} from your cart.")
    end
  end
end
