class UsersController < ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    user = params[:user]
    user[:email] = user[:email].downcase
    new_user = User.new(user_params)
    session[:user_id] = new_user.id

    if user[:password] != user[:password_confirmation]
      flash[:error] = "Error! Passwords do not match."
      redirect_to register_path
    elsif new_user.save
      flash[:success] = "Password matches. Welcome, #{new_user.name}!"
      redirect_to user_path(new_user)
    else
      flash[:error] = new_user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end 

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = "Error! Incorrect credentials."
      # render :login_form
      redirect_to login_path
    end
  end

  def logout_user
    session[:user_id] = nil
    redirect_to root_path
    flash[:success] = "Logged out successfully."
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :logout)
  end 
end 