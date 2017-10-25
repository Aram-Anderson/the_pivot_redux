require 'rails_helper'

  feature "admin dashboard" do
    feature "admin can visit the admin dashboard" do
      scenario "I will see a heading on the page that says Admin Dashboard" do
        role = Role.create(role: 0)
        manager = create(:user, roles: [role])
        store = create(:store)
        user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
        item = create(:item, store_id: store.id)
        allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(manager)


        visit store_manager_dashboard_index_path(store.slug)
        expect(page).to have_content("Dashboard")
      end
    end



  describe "as a visitor when I visit /admin/dashboard" do
    it "I see a 404 error" do

      role = Role.create(role: 0)
      manager = create(:user, roles: [role])

      store = create(:store)
      user_role = UserRole.create(user_id: manager.id, role_id: role.id, store_id: store.id)
      item = create(:item, store_id: store.id)


      expect{visit "/#{store.slug}/manager/dashboard"}.to raise_error( ActionController::RoutingError)

    end
  end
end
