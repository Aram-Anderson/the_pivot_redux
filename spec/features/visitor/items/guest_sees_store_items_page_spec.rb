require 'rails_helper'

feature "User Can Visit a Store's Page" do
  context "when they click on a link from the root page" do
    it "reroutes them to the store items page" do
      store = create(:store)
      store_2 = create(:store)
      store.items = create_list(:item, 5)
      #As a guest customer
      visit "/"
      #when I visit "/"
      expect(current_path).to eq("/")
      #I see a list of businesses
      expect(page).to have_content store_1
      expect(page).to have_content store_2
      #and I click on a particular Store
      click_on "store_1.name"
      #I should see all the items for that store
      expect(page).to have_content("item_1")
    end
  end
end
