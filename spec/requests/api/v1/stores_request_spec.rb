require 'rails_helper'

describe 'Stores API' do
  it 'see all stores' do
    create_list(:store, 3)

    get '/api/v1/stores'

    expect(response).to have_http_status(200)

    stores = JSON.parse(response.body)
    store = stores.first

    expect(stores.count).to eq(3)
    expect(store).to have_key 'name'
    expect(store).to have_key 'slug'
    expect(item).to_not have_key 'created_at'
    expect(item).to_not have_key 'updated_at'
  end

  it 'can get one store by id' do
    id = create(:store).id

    get "/api/v1/stores/#{id}"

    store = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(store["id"]).to eq(id)
    expect(store).to have_key 'name'
    expect(store).to have_key 'slug'
    expect(item).to_not have_key 'created_at'
    expect(item).to_not have_key 'updated_at'
  end

  it 'can create a store' do
    store_params ={ name: "Wally World", slug: "slug"}
    post "/api/v1/stores", params: {store: store_params}
    store = Store.last

    assert_response :success
    expect(response).to have_http_status(:created)
    expect(store).to have_key 'name'
    expect(store).to have_key 'slug'
    expect(item).to_not have_key 'created_at'
    expect(item).to_not have_key 'updated_at'
  end

  it 'can update a store' do
    id = create(:store).id
    previous_name = Store.last.name
    store_params = {name: "Wally World", slug: "slug"}

    put "/api/v1/stores/#{id}", params: {store: store_params}
    store = Store.find_by(id: id)

    expect(response).to have_http_status(200)
    expect(store.name).to eq(store_params[:name])
    expect(store.slug).to eq(item_params[:slug])
    expect(store.name).to_not eq(previous_name)
  end

  it 'can delete a store' do
    store = create(:store)
    expect(Store.count).to eq(1)
    delete "/api/v1/stores/#{store.id}"

    expect(response).to have_http_status(:no_content)
  end
end
