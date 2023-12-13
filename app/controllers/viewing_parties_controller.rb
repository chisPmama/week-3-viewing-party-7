class ViewingPartiesController < ApplicationController 
  before_action :require_login, only: :new

  def new
    @user = User.find(params[:user_id])
    @movie = Movie.find(params[:movie_id])
  end 
  
  def create 
    user = User.find(params[:user_id])
    user.viewing_parties.create(viewing_party_params)
    redirect_to "/dashboard/#{params[:user_id]}"
  end 

  private 

  def viewing_party_params 
    params.permit(:movie_id, :duration, :date, :time)
  end 

  def require_login
    @movie = Movie.find(params[:movie_id])
    unless current_user
      redirect_to movie_visit_path(@movie)
      flash[:error] = "Error! You must be logged in or registered to access the dashboard."
    end
  end
end 