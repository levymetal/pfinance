class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:currency)
  end

  # def new
  #   flash[:info] = 'Registrations are not open.'
  #   redirect_to root_path
  # end

  # def create
  #   flash[:info] = 'Registrations are not open.'
  #   redirect_to root_path
  # end
end