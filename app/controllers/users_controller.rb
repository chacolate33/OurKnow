class UsersController < ApplicationController
  # skip_before_action :require_sign_in! 
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    # 以下所属グループ一覧の記述
    @group_users = GroupUser.where(user_id: @user.id)
    @groups = []
    @group_users.each do |group_user|
      group = Group.find_by(id: group_user.group_id)
      @groups.push(group)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :mail)
    end
end
