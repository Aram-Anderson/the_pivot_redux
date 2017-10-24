require 'rails_helper'

RSpec.describe "As a user" do
	describe "visits /orders" do
		it "can see all past orders" do
			store = create(:store)
			user = User.create(first_name: "Tester", last_name: "McTesty", email: "testerson@testmail.com", password: "testing", address: "dummy address", phone: "+13033332222")
			item1, item2 = create_list(:item, 2, store: store)
			order_1 = user.orders.create(status: "ordered")
			OrderItem.create(order: order_1, item: item2, quantity: 2)
			OrderItem.create(order: order_1, item: item1, quantity: 1)
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
			visit '/orders'
			expect(page).to have_content(order_1.id)
			expect(page).to have_content(order_1.status.capitalize)
			expect(page).to have_content("26.97")
		end
	end
end
