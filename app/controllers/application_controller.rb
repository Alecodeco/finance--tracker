class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  helper_method :logged_in?, :has_empty_objects, :not_friends_with?

  def has_empty_objects?(array)
    if !array.nil?
      array.each do |object|
        return object.nil?
      end
    else
      return array.blank?
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

end
