require 'rails_helper'

describe "Stores Relationships API" do

  it "returns a collection of associated items" do
    store = create(:store)
    category = create(:category)
    item1 = create(:item, store: store, category: category)
    item2 = create(:item, store: store, category: category)
    platform_admin = create(:user, platform_admin: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(platform_admin)

    get "/api/v1/stores/#{store.id}/items"

    items = JSON.parse(response.body)
    expect(response).to be_success
    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item1.id)
    expect(items.last["id"]).to eq(item2.id)
  end
end
