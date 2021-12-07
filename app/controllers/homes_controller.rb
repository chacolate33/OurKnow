class HomesController < ApplicationController
  skip_before_action  :require_sign_in!
  def top
    @current_user = User.find_by(id: session[:user_id])
  end
end
