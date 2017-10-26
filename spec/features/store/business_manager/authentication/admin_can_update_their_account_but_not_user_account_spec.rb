require "rails_helper"

describe "As a logged in Admin" do
  it "I can modify my account data" do
    role = Role.create(role: 0)
    manager = create(:user, roles: [role])
    store = create(:store)
    user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
    item = create(:item, store_id: store.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)

    visit "/dashboard"

    click_on "Edit Account"
    fill_in "user[password]", with: "testing"
    fill_in "user[email]", with: "testerson@testmail.com"

    click_on "Submit"
    expect(manager.password).to eq("testing")


  end

    it "But I cannot modify any other user’s account data" do
      role = Role.create(role: 0)
      manager = create(:user, roles: [role])
      user = create(:user)
      store = create(:store)
      user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
      item = create(:item, store_id: store.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)

      visit dashboard_index_path(user)

      expect(page).not_to have_content("Update account")

    end

    it "A visitor sees a 404 when they try to visit the admin dashboard" do
      role = Role.create(role: 0)
      manager = create(:user, roles: [role])
      user = create(:user)
      store = create(:store)
      user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
      item = create(:item, store_id: store.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(user)

      expect{visit "/#{store.slug}/manager/dashboard"}.to raise_error( ActionController::RoutingError)
      # visit
      # expect(page).to have_content("Routing Error")
    end
  end
