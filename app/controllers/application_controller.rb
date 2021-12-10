class ApplicationController < ActionController::Base

  before_action :current_user
  before_action :require_sign_in!
  helper_method :signed_in?

  protect_from_forgery with: :exception

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end


  def sign_out
    @current_user = nil
  end

  def signed_in?
    @current_user.present?
  end

  private
  def require_sign_in!
    redirect_to login_path unless signed_in?
  end
end
