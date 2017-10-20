require 'rails_helper'

feature "User Can Visit a Store's Page" do
  context "when they click on a link from the root page" do
    it "reroutes them to the store items page" do
      store = create(:store)
      store_2 = create(:store)
      store.items = create_list(:item, 5)

      visit "/"

      expect(current_path).to eq("/")

      expect(page).to have_content store_1
      expect(page).to have_content store_2

      click_on "store_1.name"
  
      expect(page).to have_content("item_1")
    end
  end
end
