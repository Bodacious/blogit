class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    @user = User.authenticate(params[:session])
    if @user
      @current_user     = @user
      session[:user_id] = @user.id
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
