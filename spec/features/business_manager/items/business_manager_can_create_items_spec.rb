require 'rails_helper'

RSpec.feature "Admin item creation" do
  context "As an authenticated admin" do
    it "I can create an item" do
      role = Role.create(role: 0)
      manager = create(:user, roles: [role])
      store = create(:store)
      user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
      item = create(:item, store_id: store.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)
      visit "/#{store.slug}/manager/items"

      click_on "Create New Item"

      fill_in "item[title]", with: "Onesie"
      fill_in "item[description]", with: "This Onesie is awesome!"
      fill_in "item[price]", with: "59.99"
      page.attach_file("item[image]", Rails.root + 'app/assets/images/alien-onsie.png')

      click_on "Create Item"

      expect(current_path).to eq("/#{store.slug}/manager/items")
      expect(page).to have_content("Onesie")
      expect(page).to have_content("59.99")
    end

    context "I can create an item without an image and it defaults" do
      it "I can create an item" do
        role = Role.create(role: 0)
        manager = create(:user, roles: [role])
        store = create(:store)
        user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
        item = create(:item, store_id: store.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)
        visit "/#{store.slug}/manager/items"

        click_on "Create New Item"

        fill_in "item[title]", with: "Onesie"
        fill_in "item[description]", with: "This Onesie is awesome!"
        fill_in "item[price]", with: "59.99"

        click_on "Create Item"

        expect(current_path).to eq("/#{store.slug}/manager/items")
        expect(page).to have_content("Onesie")
        expect(page).to have_content("59.99")
      end
    end
  end
end
