class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in? # DO WE NEED TO ADD require_logged_in here?

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end
  
  
end
