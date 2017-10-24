require 'rails_helper'

RSpec.feature "Unauthenticated users security" do
  context "As an unauthenticated user" do
    it "I cannot view another user’s private data" do
      store = create(:store)
      item1, item2, item3, item4, item5 = create_list(:item, 5, store: store)
      order = create(:order)
      visit dashboard_index_path

      expect(current_path).to eq(login_path)

      visit order_path(order)

      expect(current_path).to eq(login_path)
    end
    it "I should be redirected to login/create account when I try to check out" do
      store = create(:store)
      item1, item2, item3, item4, item5 = create_list(:item, 5, store: store)
      order = create(:order)
      visit store_item_path(store.slug, item1.id)
      click_on "Add to cart"

      click_on "Cart"

      expect(page).to_not have_content("Checkout")

      visit new_order_path

      expect(current_path).to eq(login_path)
    end
  end
end
