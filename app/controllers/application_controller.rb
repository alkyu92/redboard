class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    # Check if current user has log in or not
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in to access this page"
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
        redirect_to request.referrer || root_url unless current_user.admin?
    end
end
