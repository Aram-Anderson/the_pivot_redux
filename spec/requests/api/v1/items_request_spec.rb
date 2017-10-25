require 'rails_helper'

describe 'Items API' do
  it 'see all items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to have_http_status(200)

    items = JSON.parse(response.body)
    item = items.first

    expect(items.count).to eq(3)
    expect(item).to have_key 'title'
    expect(item).to have_key 'description'
    expect(item).to have_key 'price'
    expect(item).to have_key 'image'
    expect(item).to_not have_key 'created_at'
    expect(item).to_not have_key 'updated_at'
  end

  it 'can get one item by id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(item["id"]).to eq(id)
    expect(item).to have_key 'title'
    expect(item).to have_key 'description'
    expect(item).to have_key 'price'
    expect(item).to have_key 'image'
    expect(item).to_not have_key 'created_at'
    expect(item).to_not have_key 'updated_at'
  end

  it 'can create an item' do
    item_params ={ title: "Cup", description: "To hold our liquid drinks", image: "http://via.placeholder.com/350x150", price: 1.99 }

    post "/api/v1/items", params: {item: item_params}
    item = Item.last

    assert_response :success
    expect(response).to have_http_status(:created)
    expect(item.title).to eq(item_params[:title])
    expect(item.description).to eq(item_params[:description])
    expect(item.image).to eq(item_params[:image])
    expect(item.price).to eq(item_params[:price])
  end

  it 'can update an item' do
    id = create(:item).id
    previous_name = Item.last.title
    item_params = {title: "Cup", description: "Hold your liquids!", image: "http://via.placeholder.com/350x150", price: 1.99}

    put "/api/v1/items/#{id}", params: {item: item_params}
    item = Item.find_by(id: id)

    expect(response).to have_http_status(200)
    expect(item.title).to eq(item_params[:title])
    expect(item.description).to eq(item_params[:description])
    expect(item.image).to eq(item_params[:image])
    expect(item.price).to eq(item_params[:price])
    expect(item.title).to_not eq(previous_name)
  end

  it 'can delete an item' do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to have_http_status(:no_content)
  end
end
