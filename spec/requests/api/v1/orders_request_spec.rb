require 'rails_helper'

describe 'Orders API' do
  it 'sees all orders' do
    create_list(:order, 5)

    get '/api/v1/orders'

    expect(response).to have_http_status(200)

    orders = JSON.parse(response.body)
    order = orders.first

    expect(orders.count).to eq(5)
    expect(order).to have_key 'status'
    expect(order).to have_key 'user_id'
    expect(order).to have_key 'created_at'
    expect(order).to have_key 'updated_at'
    expect(order).to_not have_key 'image_file_name'
    expect(order).to_not have_key 'image_content_type'
    expect(order).to_not have_key 'image_file_size'
    expect(order).to_not have_key 'image_updated_at'
  end

  it 'can get one order by id' do
    id = create(:order).id

    get "/api/v1/orders/#{id}"

    order = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(order["id"]).to eq(id)
    expect(order).to have_key 'status'
    expect(order).to have_key 'user_id'
    expect(order).to_not have_key 'created_at'
    expect(order).to_not have_key 'updated_at'
    expect(order).to_not have_key 'image_file_name'
    expect(order).to_not have_key 'image_content_type'
    expect(order).to_not have_key 'image_file_size'
    expect(order).to_not have_key 'image_updated_at'
  end

  it 'can update an order status' do
    id = create(:order).id
    previous_status = Order.last.status
    order_params = {status: "Paid"}

    put "/api/v1/orders/#{id}", params: {order: order_params}
    order = Order.find_by(id: id)

    expect(response).to have_http_status(200)
    expect(order.status).to eq(item_params[:status])
    expect(order.status).to_not eq(previous_status)
  end

  it 'can create an order' do
    order_params = { status: "Paid", user_id: 1 }

    post "/api/v1/orders", params: { order: order_params}
    order = Order.last

    assert_response :success
    expect(response).to have_http_status(:created)
    expect(order.status).to eq(order_params[:status])
    expect(order.status).to eq(order_params[:user_id])
  end

  it 'can delete an order' do
    order = create(:order)

    expect(Order.count).to eq(1)

    delete "/api/v1/orders/#{order.id}"

    expect(response).to have_http_status(:no_content)
  end
end
