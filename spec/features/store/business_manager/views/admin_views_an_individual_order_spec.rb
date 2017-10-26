require 'rails_helper'

feature "Admin can view individual order pages" do


  scenario "As an admin, when I visit an individual order page" do
    role = Role.create(role: 0)
    manager = create(:user, roles: [role])
    store = create(:store)
    user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)

    order_1 = manager.orders.create(status: 0)
    @item_one = create(:item)
    @item_two = create(:item)
    OrderItem.create(order: order_1, item: @item_one, quantity: 1)
    OrderItem.create(order: order_1, item: @item_two, quantity: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(manager)

    visit store_manager_order_path(store.slug, order_1)

    expect(page).to have_content(order_1.date)

    expect(page).to have_content(manager.address)


    expect(page).to have_link(@item_one.title)
    expect(page).to have_content(@item_one.order_items.first.quantity)
    expect(page).to have_content(@item_one.price)
    expect(page).to have_content(@item_one.price)

    expect(page).to have_link(@item_two.title)
    expect(page).to have_content(@item_two.order_items.last.quantity)
    expect(page).to have_content(@item_two.price)


  end
end

# And I can see, for each item on the order:
#
# The item’s name, which is linked to the item page.
# Quantity in this order.
# Price
# Line item subtotal. And I can see the total for the order. And I can see the status for the order.
