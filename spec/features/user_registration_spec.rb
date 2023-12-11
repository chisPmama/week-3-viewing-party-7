require "rails_helper"

# As a visitor 
# When I visit `/register`
# I see a form to fill in my name, email, password, and password confirmation.
# When I fill in that form with my name, email, and matching passwords,
# I'm taken to my dashboard page `/users/:id`

RSpec.describe "User Registration" do
  it 'has a form that will fill in the user name, email, password' do
    # When I visit `/register`
    visit register_path

    # I see a form to fill in my name, email, password, and password confirmation.
    expect(page).to have_field(:username)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_field(:password_repeat)

    username = "crisPchisP"
    password = "candycanes"

    # When I fill in that form with my name, email, and matching passwords,
    fill_in :username, with: username
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_repeat, with: password

    click_on "Create User"

    # I'm taken to my dashboard page `/users/:id`
    id = User.last.id
    expect(current_path).to eq(user_path(id))
    expect(page).to have_content("Password matches. Welcome, #{username}!")
  end
end