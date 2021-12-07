class SessionsController < ApplicationController
  skip_before_action  :require_sign_in!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    # if User.exists?(name: session_params[:name], mail: session_params[:mail])
    #   redirect_to user_path
    # else
    #   render 'new'
    # end

    if User.exists?(name: session_params[:name], mail: session_params[:mail])
      @user = User.find_by(name: session_params[:name], mail: session_params[:mail])  
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

    def session_params
      params.require(:user).permit(:name, :mail)
    end

end
