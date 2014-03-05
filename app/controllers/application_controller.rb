class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_timezone 

  check_authorization :unless => :devise_controller?

  def set_timezone
    Time.zone = current_user.time_zone if current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to new_user_session_path, :notice => exception.message
    else
      redirect_to root_url, :notice => exception.message
    end
  end
end
