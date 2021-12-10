class KnowledgesController < ApplicationController
  def ensure_current_user
    @group = Group.find(params[:group_id])
    unless GroupUser.exists?(group_id: @group.id, user_id: current_user.id)
      flash[:notice] = "Not authorized"
      redirect_to root_path
    end
  end

  def index
    @group = Group.find(params[:group_id])
    @knowledge = Knowledge.new
    # 並び替え機能
    # 五十音順
    if params[:sort_aiu]
      @knowledges = Knowledge.where(group_id: @group.id).order(japanese: "ASC")
    # 新しい順
    elsif params[:sort_new]
      @knowledges = Knowledge.where(group_id: @group.id).order(created_at: "DESC")
    # デフォルト(古い順)
    else
      @knowledges = Knowledge.where(group_id: @group.id)
    end
    @knowledges = Kaminari.paginate_array(@knowledges).page(params[:page]).per(20)
  end

  def show
    # 表示すべきknowledgeがあればページを表示
    if Knowledge.exists?(params[:id])
      @knowledge = Knowledge.find(params[:id])
      @comments = @knowledge.comments
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @knowledge = Knowledge.find(params[:id])
    @knowledge.destroy
    redirect_to group_knowledges_path(@group)
  end

  def edit
    @knowledge = Knowledge.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  def update
    @knowledge = Knowledge.find(params[:id])
    @group = Group.find(params[:group_id])
    @knowledge.update(knowledge_params)
    if @knowledge.save
      flash[:notice] = "You have updated phrase successfully."
      redirect_to group_knowledges_path(@knowledge.group_id)
    else
      render :edit
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @knowledge = Knowledge.new(knowledge_params)
    @knowledge.group_id = @group.id
    @knowledge.user_id = current_user.id
    if @knowledge.save
      flash[:notice] = "You have created knowledge successfullly."
      redirect_to group_knowledges_path(@group)
    else
      @knowledges = Knowledge.where(group_id: @group.id)
      @knowledges = Kaminari.paginate_array(@knowledges).page(params[:page]).per(20)
      render :index
    end
  end

  private

  def knowledge_params
    params.permit(:content)
  end
end
