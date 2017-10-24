require 'rails_helper'

feature "a registered user" do
  scenario "is able to edit account information" do
    user = User.create(first_name: "danny", last_name: "t", email: "a@b.com", password: "123", phone: "+12023332222")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to have_content("Edit Account")

    click_on "Edit Account"

    expect(current_path).to eq("/users/#{user.id}/edit")

    fill_in "user[first_name]", with: "louie"
    fill_in "user[last_name]", with: "k.f.c."
    fill_in "user[email]", with: "email@email.com"
    fill_in "user[password]", with: "456"
    fill_in "user[address]", with: "changed address"

    click_on "Submit"

    expect(current_path).to eq("/dashboard")

    expect(User.first[:first_name]).to eq("louie")
    expect(User.first[:last_name]).to eq("k.f.c.")
    expect(User.first[:email]).to eq("email@email.com")
    expect(User.first[:address]).to eq("changed address")
  end
end
