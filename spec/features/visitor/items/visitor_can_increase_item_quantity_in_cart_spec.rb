require 'rails_helper'

feature "Visitor can increase an item's quantity in the cart" do
  scenario "visitor has an item in the cart and then she increases it to 2" do
    store = create(:store)
    item1, item2, item3 = create_list(:item, 3, store: store)
    visit store_item_path(store.slug, item1)

    click_on "Add to cart"

    visit carts_path
    expect(page).to have_content(item1.title)
    expect(page).to have_content(1)
    expect(page).to have_content(item1.price)

    click_on "+"

    expect(current_path).to eq('/cart')
    expect(page).to have_content(item1.title)

    expect(page).to have_content(2)
    expect(page).to have_content("$17.98")
  end
end
