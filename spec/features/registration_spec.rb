require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    # When I visit `/register`
    visit register_path

    # I see a form to fill in my name, email, password, and password confirmation.
    expect(page).to have_field("user[name]")
    expect(page).to have_field("user[email]")
    expect(page).to have_field("user[password]")
    expect(page).to have_field("user[password_confirmation]")

    name = "crisP chisP"
    password = "candycanes"
    email = "chisP@gmail.com"

    # When I fill in that form with my name, email, and matching passwords,
    fill_in "user[name]", with: name
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: password

    click_on "Create an Account"

    # I'm taken to my dashboard page `/users/:id`
    user = User.last
    expect(current_path).to eq(user_path(user.id))
    expect(page).to have_content("Password matches. Welcome, #{name}!")
    expect(user).to_not have_attribute(:password)
    expect(user.password_digest).to_not eq(password)
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', password: "test", password_confirmation: "test", email: 'notunique@example.com')

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    click_button 'Create an Account'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  it 'does not create a user if email isnt unique' do 
    visit register_path

    name = "crisP chisP"
    password = "candycanes"
    email = "chisP@gmail.com"

    # When I fill in that form with my name, email, and matching passwords,
    fill_in "user[name]", with: name
    fill_in "user[email]", with: email
    fill_in "user[password]", with: password
    fill_in "user[password_confirmation]", with: "badbadbad"

    click_on "Create an Account"
    expect(current_path).to eq(register_path)
    expect(page).to have_content("Error! Passwords do not match.")
  end
end
