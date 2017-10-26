require 'rails_helper'

RSpec.feature "Admin Orders" do
  context "As an admin" do
    it "I can see the total number of orders for each status" do
      role = Role.create(role: 0)
      manager = create(:user, roles: [role])
      store = create(:store)
      user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
      item = create(:item, store_id: store.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)
      order = store.orders.create( status: 0, user: manager)
      order.items << item

      visit store_manager_dashboard_index_path(store.slug)
      click_on "Orders"

      expect(page).to have_content(order.id)
      expect(page).to have_content(order.date)
      expect(page).to have_content(order.status.capitalize)
    end

    it "I can see orders filtered by status" do

      role = Role.create(role: 0)
      manager = create(:user, roles: [role])
      store = create(:store)
      user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
      item1 = create(:item, store_id: store.id)
      item2 = create(:item, store_id: store.id)
      item3 = create(:item, store_id: store.id)
      item4 = create(:item, store_id: store.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)
      order1 = store.orders.create( status: 0, user: manager)
      order2 = store.orders.create( status: 1, user: manager)
      order3 = store.orders.create( status: 2, user: manager)
      order4 = store.orders.create( status: 3, user: manager)
      order1.items << item1
      order2.items << item2
      order3.items << item3
      order4.items << item4

      visit "/#{store.slug}/manager/orders?status=ordered"
      expect(page).to have_content(order1.id)
      expect(page).to have_content(order1.date)
      expect(page).to have_content(order1.status.capitalize)

      visit "/#{store.slug}/manager/orders?status=paid"
      expect(page).to have_content(order2.id)
      expect(page).to have_content(order2.date)
      expect(page).to have_content(order2.status.capitalize)


      visit "/#{store.slug}/manager/orders?status=cancelled"
      expect(page).to have_content(order3.id)
      expect(page).to have_content(order3.date)
      expect(page).to have_content(order3.status.capitalize)

      visit "/#{store.slug}/manager/orders?status=completed"
      expect(page).to have_content(order4.id)
      expect(page).to have_content(order4.date)
      expect(page).to have_content(order4.status.capitalize)


    end

    it "I can change the status of orders" do
      role = Role.create(role: 0)
      manager = create(:user, roles: [role])
      store = create(:store)
      user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
      item1 = create(:item, store_id: store.id)
      item2 = create(:item, store_id: store.id)
      item3 = create(:item, store_id: store.id)
      item4 = create(:item, store_id: store.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)
      order1 = store.orders.create( status: 0, user: manager)
      order2 = store.orders.create( status: 1, user: manager)
      order3 = store.orders.create( status: 2, user: manager)
      order4 = store.orders.create( status: 3, user: manager)
      order1.items << item1
      order2.items << item2
      order3.items << item3
      order4.items << item4

      visit "/#{store.slug}/manager/orders"

      within(".order-2") do
        click_on("Cancel")
      end

      expect(current_path).to eq("/#{store.slug}/manager/orders")

      within(".order-2") do
        expect(page).to have_content("Cancelled")
      end

      within(".order-1") do
        click_on("Mark as Paid")
      end

      within(".order-1") do
        within(".status") do
          expect(page).to have_content("Paid")
        end
      end

      within(".order-1") do
        click_on("Mark as Completed")
      end

      within(".order-1") do
        within(".status") do
          expect(page).to have_content("Completed")
        end
      end


    end
  end
end
