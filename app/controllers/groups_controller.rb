class GroupsController < ApplicationController
# グループ作成者でないと、そのグループの編集をできないようにする
  def ensure_current_user
    @group = Group.find(params[:id])
    if current_user.id != @group.leader_id
      flash[:notice] = "Not authorized"
      redirect_to root_path
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.leader_id = current_user.id
    @group.save
    group_user = GroupUser.new
    group_user.user_id = current_user.id
    group_user.group_id = @group.id

    if group_user.save
      redirect_to user_path(current_user), notice: 'You have made new group.'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    if @group.save
      flash[:notice] = "You have updated group successfully."
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def show
    # 表示するべきグループがあれば詳細画面を表示
    if Group.exists?(params[:id])
      @group = Group.find(params[:id])
      @leader = User.find_by(id: @group.leader_id)
      # 承認があればグループリーダーの画面に承認待ち一覧へのボタンを設置
      @applies = Apply.where(group_id: params[:id])
      # グループへの加入申請をしていればキャンセルボタンを設置
      @apply = Apply.find_by(group_id: @group.id, user_id: current_user.id)
      # 所属ユーザー一覧表示
      @group_users = GroupUser.where(group_id: @group.id)
      @users = []
      @group_users.each do |group_user|
        user = User.find_by(id: group_user.user_id)
        @users.push(user)
      end
      @users = Kaminari.paginate_array(@users).page(params[:page]).per(20)
    else
      # グループを削除したことにより表示できない場合はグループ一覧に遷移
      redirect_to groups_path
    end
  end

  def index
    @groups = Group.all.order(created_at: "DESC").page(params[:page]).per(20)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to request.referer
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end