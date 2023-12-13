require 'rails_helper'

RSpec.describe 'Landing Page' do
  describe 'Original Work' do
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
  
    # xit 'lists out existing users' do 
    #   user1 = User.create(name: "User_One", email: "user1@test.com")
    #   user2 = User.create(name: "User_Two", email: "user2@test.com")
  
    #   expect(page).to have_content('Existing Users:')
  
    #   within('.existing-users') do 
    #     expect(page).to have_content(user1.email)
    #     expect(page).to have_content(user2.email)
    #   end     
    # end
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
    
    it 'can properly logout the user with an exchange of links and buttons' do
      visit root_path

      expect(page).to_not have_link("Log In")
      expect(page).to_not have_button("Create an Account")

      expect(page).to have_link("Log Out")

      click_link "Log Out"

      expect(current_path).to eq(root_path)
      expect(page).to_not have_link("Log Out")
      expect(page).to have_link("Log In")
      expect(page).to have_button("Create an Account")
    end
  end

  describe 'Authorization Challenge' do
    before :each do 
      @user1 = User.create(name: "Candy Canes", password: "test", password_confirmation: "test", email: "candycandy@test.com")
      @user2 = User.create(name: "Butter Butt", password: "test", password_confirmation: "test", email: "buttbutt@test.com")
      @user3 = User.create(name: "ChisP", password: "candycanes", password_confirmation: "candycanes", email: "chisP@gmail.com")
    
      visit root_path
    end 

    it 'when visiting the landing page, the section of the page that lists existing users is not there if not logged in' do
      expect(page).to_not have_content(@user1.email)
      expect(page).to_not have_content(@user2.email)
      expect(page).to_not have_content(@user3.email)
    end

    it 'when logged in, user can see the list of emails' do
      click_link "Log In"
      fill_in :email, with: @user3.email
      fill_in :password, with: @user3.password
      click_button "Log In"
      visit root_path

      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
      expect(page).to have_content(@user3.email)
    end

    it "when trying to visit the dashboard, user remains on the landing page with a message saying user must be logged in" do
      visit dashboard_path(@user3)
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Error! You must be logged in or registered to access the dashboard.")
    end
  end
end
