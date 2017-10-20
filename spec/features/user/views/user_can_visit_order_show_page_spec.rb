require 'rails_helper'

RSpec.describe "As a user" do
	describe "visits /orders" do
		it "can see all past orders" do
			category = create(:category)
			store = create(:store)
			item1 = create(:item, category: category, store: store)
			item2 = create(:item, category: category, store: store)
			user = User.create(first_name: "Tester", last_name: "McTesty", email: "testerson@testmail.com", password: "testing", address: "dummy address")

			order_1 = user.orders.create(status: "ordered")
			OrderItem.create(order: order_1, item: item1, quantity: 1)
			OrderItem.create(order: order_1, item: item2, quantity: 2)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
			visit '/orders'
			click_on order_1.id
			expect(current_path).to eq(order_path(order_1))
			expect(page).to have_content("Total: $26.97")
		end
	end
end
