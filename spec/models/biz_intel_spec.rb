require 'rails_helper'

describe "analytics class" do
  before(:each) do
    more_orders
    @analytics = BizIntel.new
  end

  it "can return total_sales" do
    expect(@analytics.total_sales).to eq(109.98)
  end

  it "can return the average quantity of purchased items" do
    expect(@analytics.average_quantity_purchased).to eq (2)
  end

  it "can return a count of completed orders" do
    expect(@analytics.completed_orders).to eq (1)
  end

  it "can return a total of sales by item title" do
    expected_hash = {"Adult Penguin"=>3, "Adult Squirrel - Pink/White"=>2, "Adult Tiger"=>4, "Young Pikachu - Boy"=>1, "Adult Giraffe"=>3, "Adult Zebra"=>1, "Baby Unicorn"=>1, "Adult Sloth"=>1}
    expect(@analytics.sales_by_item_title).to eq (expected_hash)
  end

  it "can return a total of sales by item title" do
    expected_hash = {["Adult Penguin", 2]=>1, ["Adult Squirrel - Pink/White", 0]=>1, ["Adult Zebra", 1]=>1, ["Adult Giraffe", 3] => 1, ["Adult Tiger", 3] => 1, ["Young Pikachu - Boy", 2]=>1, ["Adult Sloth", 1]=>1, ["Baby Unicorn", 0]=>1}
    expect(@analytics.status_for_items).to eq (expected_hash)
  end

  it "can return orders by users" do
    expected_hash = {"jake@adventuretime.com"=>2, "mimi@mimi.com"=>2}
    expect(@analytics.orders_per_customer).to eq(expected_hash)
  end

  it "can return items ordered by a customer" do
    expected_hash = {"jake@adventuretime.com"=>11, "mimi@mimi.com"=>5}
    expect(@analytics.items_ordered_per_customer).to eq(expected_hash)
  end
end
