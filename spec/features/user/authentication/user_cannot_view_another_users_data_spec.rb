require 'rails_helper'

RSpec.feature "Authenticated users security" do
  context "As a user" do
    it "I cannot view another user’s private data" do
      user = create(:user, email: "thing@thing.com", password: "123")
      order = create(:order)
      visit root_path

      click_on "Login"

      fill_in "session[email]", with: "thing@thing.com"
      fill_in "session[password]", with: "123"

      within(".action") do
        click_on("Login")
      end

      expect(current_path).to eq(dashboard_index_path)

      visit order_path(order)

      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content(user.first_name)
    end
    it "I cannot view the administrator screens" do
      user = create(:user, email: "thing@thing.com", password: "123")
      order = create(:order)
      visit root_path

      click_on "Login"

      fill_in "session[email]", with: "thing@thing.com"
      fill_in "session[password]", with: "123"

      within(".action") do
        click_on("Login")
      end


      expect(page).to_not have_content("My Stores")
    end
  end
end
