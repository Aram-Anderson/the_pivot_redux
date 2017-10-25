require 'rails_helper'

RSpec.feature "Admin Orders" do
  context "As an admin" do
    xit "I can see the total number of orders for each status" do
      role = Role.create(role: 0)
      manager = create(:user, roles: [role])
      store = create(:store)
      user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
      item = create(:item, store_id: store.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)
      order = create(:order)
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
      order1 = create(:order, status: 0)
      order2 = create(:order, status: 1)
      order3 = create(:order, status: 2)
      order4 = create(:order, status: 3)
      order1.items << item1
      order2.items << item2
      order3.items << item3
      order4.items << item4


      visit store_manager_dashboard_index_path(store.slug)

      click_on "Orders"

    save_and_open_page
      click_on("Ordered")


      expect(current_path).to eq(store_manager_orders_path(store.slug))
      expect(page).to have_link(order1.id, store_manager_order_path(store.slug, order1))
      expect(page).not_to have_link(order2.id)
      expect(page).not_to have_link(order3.id)
      expect(page).not_to have_link(order4.id)
    end

    xit "I can change the status of orders" do
      visit admin_dashboard_index_path

      within(".order-2") do
        click_on("Cancel")
      end

      expect(current_path).to eq(admin_dashboard_index_path)

      within(".order-2") do
        expect(page).to have_content("Cancelled")
      end

      within(".order-1") do
        click_on("Mark as Paid")
      end

      expect(current_path).to eq(admin_dashboard_index_path)

      within(".order-1") do
        within(".status") do
          expect(page).to have_content("Paid")
        end
      end

      within(".order-1") do
        click_on("Mark as Completed")
      end

      expect(current_path).to eq(admin_dashboard_index_path)

      within(".order-1") do
        within(".status") do
          expect(page).to have_content("Completed")
        end
      end

    end
  end
end
