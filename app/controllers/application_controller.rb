class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :except => [:index, :about]

  def after_sign_in_path_for(resource_or_scope)
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      subscriptions_path
    end
  end
end
