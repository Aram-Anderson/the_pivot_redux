require "rails_helper"

describe "item business intelligence API" do

  it "returns the top items ranked by most ordered" do
    user = create(:user, platform_admin: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)
    category = create(:category)

    store1 = create(:store)
    store2 = create(:store)
    item1 = create(:item, store: store1, category: category)
    item2 = create(:item, store: store1, category: category)
    item3 = create(:item, store: store2, category: category)
    item4 = create(:item, store: store2, category: category)
    order1 = create(:order, user: user, status: 1)
    order2 = create(:order, user: user, status: 1)
    order3 = create(:order, user: user,  status: 1)
    order_item1 = OrderItem.create(order: order1, item:item1, quantity: 2)
    order_item2 = OrderItem.create(order: order2, item:item1, quantity: 3)
    order_item3 = OrderItem.create(order: order3, item:item2, quantity: 4)
    order_item4 = OrderItem.create(order: order3, item:item3, quantity: 5)
    order_item5 = OrderItem.create(order: order2, item:item4, quantity: 7)

    get "/api/v1/items/most_popular"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items[0]["id"]).to eq(item4.id)
    expect(items[1]["id"]).to eq(item1.id)
    expect(items.count).to eq(10)
  end
end
