require 'rails_helper'

RSpec.describe 'an admin can visit admin dashboard' do
	describe 'and see a link for all items' do
		it 'when clicked that link should be the admin item index with admin functionality' do
			Role.create([{role: 0}, {role: 1}])
			
			bus_man = Role.find(1)
			bus_admin = Role.find(2)
			
			admin_user = User.create(first_name: "Admin", last_name: "McAdmin", email: "admin@admin.com", password: "boom", roles: [bus_man])
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)
			two_items

			visit admin_dashboard_index_path

			click_on "View Items"

			expect(page).to have_content(@item_one.title)
			expect(page).to have_content(@item_one.price)
			expect(page).to have_content(@item_two.title)
			expect(page).to have_content(@item_two.price)
			expect(page).to have_content("Edit")
		end
	end
end
