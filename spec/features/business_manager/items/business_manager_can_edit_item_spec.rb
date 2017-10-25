require 'rails_helper'

feature "business manager can edit item" do
  scenario "as a logged in business manager" do
    role = Role.create(role: 0)
    manager = create(:user
    )
    store = create(:store)
    user_role = UserRole.create(user: manager, role: role, store: store)
    item = create(:item, store: store)
    allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)

    visit "/#{store.slug}/manager/items"

    first('.item').click_on('Edit')

    fill_in "item[title]", with: "new item title"
    fill_in "item[description]", with: "new description"
    fill_in "item[price]", with: 100.0
    page.attach_file("item[image]", Rails.root + 'app/assets/images/alien-onsie.png')

    click_on "Update Item"

    expect(current_path).to eq("/#{store.slug}/manager/items")

    expect(page).to have_content("new item title")
    expect(page).to have_content("new description")
    expect(page).to have_content(100.0)
  end
end
