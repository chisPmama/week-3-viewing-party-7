require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    # When I visit `/register`
    visit register_path
    save_and_open_page

    # I see a form to fill in my name, email, password, and password confirmation.
    expect(page).to have_field(:username)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_field(:password_confirmation)

    username = "crisPchisP"
    password = "candycanes"

    # When I fill in that form with my name, email, and matching passwords,
    fill_in :username, with: username
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on "Create User"

    # I'm taken to my dashboard page `/users/:id`
    user = User.last
    expect(current_path).to eq(user_path(user.id))
    expect(page).to have_content("Password matches. Welcome, #{username}!")
    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq(password)
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com')

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end
end
