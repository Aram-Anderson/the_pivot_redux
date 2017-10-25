require 'rails_helper'

describe 'Stores API' do
  let(:user) { User.create(platform_admin: true)}

  it 'see all stores' do
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)

    create_list(:store, 3)

    get '/api/v1/stores'

    expect(response).to have_http_status(200)

    stores = JSON.parse(response.body)
    store = stores.first

    expect(stores.count).to eq(3)
    expect(store).to have_key 'name'
    expect(store).to have_key 'slug'
    expect(store).to_not have_key 'created_at'
    expect(store).to_not have_key 'updated_at'
  end

  it 'can get one store by id' do
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)

    id = create(:store).id

    get "/api/v1/stores/#{id}"

    store = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(store["id"]).to eq(id)
    expect(store).to have_key 'name'
    expect(store).to have_key 'slug'
    expect(store).to_not have_key 'created_at'
    expect(store).to_not have_key 'updated_at'
  end
end
