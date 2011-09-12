class SessionsController < ApplicationController
  
  expose(:user) { User.authenticate(params[:session]) }
  
  def new
  end
  
  def create
    if user
      @current_user     = user
      session[:user_id] = user.id
      redirect_to(root_url, notice: "Successfully logged in!")      
    else
      render :new
    end
  end
  
  def destroy
    @current_user = session[:user_id] = nil
    redirect_to(root_url, notice: "Successfully logged out!")
  end

end
