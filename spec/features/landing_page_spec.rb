require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User_One", password: "test", password_confirmation: "test", email: "user1@test.com")
    user2 = User.create(name: "User_Two", password: "test", password_confirmation: "test", email: "user2@test.com")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create an Account"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    user1 = User.create(name: "User_One", email: "user1@test.com")
    user2 = User.create(name: "User_Two", email: "user2@test.com")

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 

  describe 'Logging In/Logging Out' do
    before :each do
      @user = User.create(name: "ChisP", password: "candycanes", password_confirmation: "candycanes", email: "chisP@gmail.com")
      @email = "chisP@gmail.com"
      @password = "candycanes"

      # As a logged in user 
      # When I visit the landing page
      visit root_path
      click_link "Log In"
      fill_in :email, with: @email
      fill_in :password, with: @password
      click_button "Log In"
    end
    
    it 'does stuff' do
      visit root_path
      # I no longer see a link to Log In or Create an Account
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_button("Create an Account")
      # But I see a link to Log Out.
      expect(page).to have_link("Log Out")
      # When I click the link to Log Out
      click_link "Log Out"
      # I'm taken to the landing page
      expect(current_path).to eq(root_path)
      # And I can see that the Log Out link has changed back to a Log In link
      save_and_open_page
      expect(page).to_not have_link("Log Out")
      expect(page).to have_link("Log In")
      expect(page).to have_button("Create an Account")
      
    end
  end
end
