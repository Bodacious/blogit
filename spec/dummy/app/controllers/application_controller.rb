class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  helper_method :current_user
  
  def current_user
    # session[:user_id] = User.first.id
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def login_required
    unless current_user
      flash[:warn] = "You must be logged in to view that page!"
      redirect_to root_url
    end
  end
  
end
