require 'rails_helper'

feature "User Can Visit a Store's Page" do
  context "when they click on a link from the root page" do
    it "reroutes them to the store items page" do
      store_1 = create(:store)
      store_2 = create(:store)
      item = create(:item, store: store_1)

      visit "/"

      expect(current_path).to eq("/")

      click_on store_1.name

      expect(page).to have_content item.title
    end
  end
end
