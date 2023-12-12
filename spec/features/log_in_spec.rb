require 'rails_helper'

RSpec.describe "User Log In Page" do
  before(:each) do
    @user = User.create(name: "ChisP", password: "candycanes", password_confirmation: "candycanes", email: "chisP@gmail.com")
    @email = "chisP@gmail.com"
    @password = "candycanes"
  end

  describe 'Logging In (Happy Path)' do
    it 'can log into the user account through the landing page' do
      visit root_path

      click_link "Log In"
      expect(current_path).to eq(login_path)

      expect(page).to have_field(:email)
      expect(page).to have_field(:password)

      fill_in :email, with: @email
      fill_in :password, with: @password
      click_button "Log In"

      expect(current_path).to eq(user_path(@user))
    end
  end

  describe 'Logging In (Sad Path)' do
    it 'will return an error if credentials are incorrect' do
      visit root_path

      click_link "Log In"
      expect(current_path).to eq(login_path)

      expect(page).to have_field(:email)
      expect(page).to have_field(:password)

      fill_in :email, with: @email
      fill_in :password, with: "ohno"
      click_button "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Error! Incorrect credentials.")

    end
  end
end