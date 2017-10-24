require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do
    Role.create([{role: 0}, {role: 1}])
    user = User.create(first_name: "Tester", last_name: "McTesty", email: "testerson@testmail.com", password: "testing", address: "dummy address", phone: "+12023339999")
    store = create(:store)
    item1 = create(:item, store: store)


    visit store_items_path(store.slug)

    click_on "Add to cart"

    visit cart_path

    within(".checkout") do
      click_on("Login")
    end

    fill_in "session[email]", with: "testerson@testmail.com"
    fill_in "session[password]", with: "testing"

    within(".action") do
      click_on("Login")
    end

    click_on "Cart"

    expect(page).to have_content("Checkout")

    click_on "Checkout"

    expect(current_path).to eq('/orders')
    expect(page).to have_content("Order was successfully placed")
  end
end
