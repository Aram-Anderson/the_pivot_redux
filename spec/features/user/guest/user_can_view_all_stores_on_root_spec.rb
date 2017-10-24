require 'rails_helper'

feature "Guest User Visits The Main Root Path" do
  context "they see all stores" do
    scenario "things happen sometimes" do
      stores = create_list(:store, 6)
      visit '/'

      expect(stores.count).to eq(6)
      expect(page).to have_content("Login")
      expect(page).to have_content("Sign Up")
    end
  end
end
