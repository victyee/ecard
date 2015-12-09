class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def after_sign_in_path_for(users)
    if request.env['omniauth.origin'] == url_for(:controller => 'homes', :action => 'login')
      if current_user.admin
        admincards_path
      else
        mycards_path
      end
    else
      request.env['omniauth.origin'] || stored_location_for(users) || root_path
    end
  end
end
