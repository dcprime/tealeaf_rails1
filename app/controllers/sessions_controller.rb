class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have been logged in"
      redirect_to :root
    else
      flash[:error] = "Your login information was incorrect"
      render :new
    end
   
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to :root
  end
  
end