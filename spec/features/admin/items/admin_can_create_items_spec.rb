require 'rails_helper'

RSpec.feature "Admin item creation" do
  context "As an authenticated admin" do
    it "I can create an item" do
      Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
      default = Role.find(1)
      bus_man = Role.find(2)
      bus_admin = Role.find(3)
      plat_admin = Role.find(4)
      admin = User.create(first_name: "Mimi", last_name: "Le", email: "mimi@mimi.com", password: "mimi", roles: [bus_man])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_items_path
      two_items

      store = create(:store)
      click_on "Create New Item"

      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", Rails.root + 'app/assets/images/alien-onsie.png')
      select store.name, from: "stores"
      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end
    it "I can create an item without an image and it defaults" do
      Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
      default = Role.find(1)
      bus_man = Role.find(2)
      bus_admin = Role.find(3)
      plat_admin = Role.find(4)
      admin = User.create(first_name: "Mimi", last_name: "Le", email: "mimi@mimi.com", password: "mimi", roles: [bus_man])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_items_path
      two_items

      click_on "Create New Item"
      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      click_on "Create Item"

      expect(current_path).to eq(admin_items_path)
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")

    end
  end
end
