require 'rails_helper'

feature "As a logged in Business Manager" do
  context "I visit the root page and click on My Store" do
    scenario "and I click on a tab with all my store items" do
      role = Role.create(role: 1)
      store = create(:store)
      store2 = create(:store)
      order1, order2, order3 = create_list(:order, 3)
      item1, item2, item3 = create_list(:item, 3, store: store)
      item4 = create(:item, store: store2)
      order1.items << [item1, item2, item3]
      order2.items << [item1, item4]
      order3.items << [item2]
      manager = create(:user, roles: [role])
      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)
      visit "/#{store.slug}/manager/dashboard"
      click_on "Items"

      expect(current_path).to eq("/#{store.slug}/manager/items")
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
    end
  end
end

# As A Business Manager
# I can see a link named 'My Store'
# And I click on "My Store"
# I should be redirected to "/storename/manager/dashboard"
# Then I should see tabs with tables for all my items and orders
