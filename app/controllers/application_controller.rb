class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  helper_method :logged_in?

  def logged_in?
    true
  end


end
