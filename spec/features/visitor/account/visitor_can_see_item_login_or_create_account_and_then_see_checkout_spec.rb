require 'rails_helper'

RSpec.describe "As a visitor" do
	describe "when I visit my cart" do
		it "I can sign up or log in" do
			create(:role, role: 1)
			store = create(:store)
			item1, item2, item3 = create_list(:item, 3, store: store)

	    visit store_items_path(store.slug)
			first(".card-body").click_on "Add to cart"
			visit '/carts'
			expect(page).to have_content("Create new account")
			expect(page).to have_content("Login")
			click_on "Create new account"
			fill_in "user[first_name]", with: "Tester"
	    fill_in "user[last_name]", with: "McTesty"
	    fill_in "user[email]", with: "testerson@testmail.com"
	    fill_in "user[password]", with: "testing"
			fill_in "user[phone]", with: "+13033332222"
			allow(MessageSender).to receive(:send_code).and_return(true)
			click_on "Submit"
			visit '/carts'

			expect(page).to have_content(item1.title)
			expect(page).to have_content("1")

		end
	end
end
