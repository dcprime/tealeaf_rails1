class UsersController < ApplicationController
  
  before_action :require_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have been registered."
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(session[:user_id])
  end
  
  def update
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
end