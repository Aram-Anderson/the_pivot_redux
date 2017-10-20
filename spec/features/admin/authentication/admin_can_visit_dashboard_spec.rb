require 'rails_helper'

  feature "admin dashboard" do
    feature "admin can visit the admin dashboard" do
      scenario "I will see a heading on the page that says Admin Dashboard" do
        Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
        default = Role.find(1)
        bus_man = Role.find(2)
        bus_admin = Role.find(3)
        plat_admin = Role.find(4)
        admin_user = User.create(first_name: "Admin", last_name: "McAdmin", email: "admin@admin.com", password: "boom", roles: [bus_man])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

        visit admin_dashboard_index_path
        expect(page).to have_content("Admin Dashboard")
      end
    end
  end

  describe "as a logged in user when I visit /admin/dashboard" do
    it "I see a 404 error" do

      Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
      default = Role.find(1)
      bus_man = Role.find(2)
      bus_admin = Role.find(3)
      plat_admin = Role.find(4)

      default_user = User.create(first_name: "Admin", last_name: "McAdmin", email: "admin@admin.com", password: "boom", roles: [bus_man])

      allow_any_instance_of(ApplicationController).to receive(:current_user). and_return(default_user)

      visit admin_dashboard_index_path

      expect(page).to have_content("404")

    end
  end


  describe "as a visitor when I visit /admin/dashboard" do
    it "I see a 404 error" do

      visit admin_dashboard_index_path

      expect(page).to have_content("404")

    end
  end


feature "as an Admin" do
  describe "when I log into my account" do

    it "I am redirected to the Admin Dashboard" do
      Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
      default = Role.find(1)
      bus_man = Role.find(2)
      bus_admin = Role.find(3)
      plat_admin = Role.find(4)
      admin = User.create(first_name: "Admin", last_name:"McAdmin", email: "admin@email", password: "boom", roles: [bus_man])

      visit login_path


      fill_in "session[email]", with: admin.email
      fill_in "session[password]", with: admin.password
      within(".action") do
        click_on("Login")
      end

      expect(page).to have_content("You're logged in as an Administrator.")

      expect(current_path).to eq(admin_dashboard_index_path)
    end
  end
end
