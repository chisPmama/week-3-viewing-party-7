require 'rails_helper'

RSpec.describe 'Movies Index Page' do
  before do 
    @user1 = User.create(name: "User_One", password: "test", password_confirmation: "test", email: "user1@test.com")
    @user2 = User.create(name: "User_Two", password: "test", password_confirmation: "test", email: "user2@test.com")
    i = 1
    20.times do 
      Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
      i+=1
    end 
  end 

  it 'shows all movies' do 
    visit login_path

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password
    click_button "Log In"

    visit dashboard_path

    click_button "Find Top Rated Movies"

    expect(current_path).to eq("/dashboard/movies")
    expect(page).to have_content("Top Rated Movies")
    
    movie_1 = Movie.first

    click_link(movie_1.title)

    expect(current_path).to eq("/dashboard/movies/#{movie_1.id}")

    expect(page).to have_content(movie_1.title)
    expect(page).to have_content(movie_1.description)
    expect(page).to have_content(movie_1.rating)
  end 

  #   As a visitor
  #   If I go to a movies show page 
  #   And click the button to create a viewing party
  #   I'm redirected to the movies show page, and a message appears to let me know I must be logged in or registered to create a movie party.

  it "as a visitor (who is not logged in), when going to a movie show page to create a viewing party, the page directs to the show page and requires a login" do
    movie = Movie.last
    visit movie_visit_path(movie)
    click_button "Create a Viewing Party"
    expect(current_path).to eq(movie_visit_path(movie))
    expect(page).to have_content("Error! You must be logged in or registered to access the dashboard.")
  end
end