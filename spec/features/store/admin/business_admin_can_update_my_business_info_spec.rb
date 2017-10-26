require 'rails_helper'

feature "business admin can update business info" do
  scenario "as a business administrator" do
    role = Role.create(role: 1)
    admin = create(:user, roles: [role])
    store = create(:store)
    user_role = UserRole.create(user_id: admin.id, role_id: role.id, store_id: store.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(admin)

    visit "/#{store.slug}/admin"

    click_on "Edit Store Name"

    expect(current_path).to eq("/#{store.slug}/admin/edit")

    fill_in "store[name]", with: "New Store Name"

    click_on "Update Store"

    expect(current_path).to eq("/#{store.slug}/admin")

    expect(page).to have_content("New Store Name")
  end
end


# As A Biz Admin
# When I visit "/storename/admin"
# And I click on "Edit Store Name"
# I should be redirected to "/storename/admin/edit"
# And I fill in a new store name
# And I click on "Update Store"
# I should be redirected to "/storename/admin"
# And I should see the new store name
