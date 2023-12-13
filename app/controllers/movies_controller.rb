class MoviesController < ApplicationController
  def index 
    @user = User.find(session[:user_id])
    @movies = Movie.all
  end 

  def show 
    @user = User.find(session[:user_id])
    @movie = Movie.find(params[:id])
  end 

  def visit_show
    @movie = Movie.find(params[:id])
  end
end 