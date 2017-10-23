require 'rails_helper'

feature "Guest User Visits The Main Root Path" do
  context "they see all stores" do
    stores = create_list(:store, 6)
    visit '/'

    expect(response).to have_http_response(200)
    expect(stores.count).to eq(6)
    expect(page).to have_content("Login")
    expect(page).to have_content("Sign Up")
  end
end
