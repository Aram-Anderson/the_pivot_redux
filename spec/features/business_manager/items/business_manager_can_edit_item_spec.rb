require 'rails_helper'

feature "business manager can edit item" do
  scenario "as a logged in business manager" do
    role = Role.create(role: 0)
    manager = create(:user, roles: [role])
    store = create(:store)
    user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
    item = create(:item, store_id: store.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)

    visit "/#{store.slug}/manager/items"

    first('.item').click_on('Edit')

    fill_in "item[title]", with: "new item title"
    fill_in "item[description]", with: "new description"
    fill_in "item[price]", with: 100.0
    page.attach_file("item[image]", Rails.root + 'app/assets/images/alien-onsie.png')

    click_on "Update Item"

    expect(current_path).to eq("/#{store.slug}/manager/dashboard/items")

    expect(page).to have_content("new item title")
    expect(page).to have_content("new description")
    expect(page).to have_content(100.0)
  end
end



    # As A Business Manager
    # And I visit "/storename/manager/items"
    # And I click on "Edit Item"
    # And I fill in a new name & description
    # And I click on "Update Item"
    # I should be redirected to "/storename/manager/items"
    # Then I should see my updated item
