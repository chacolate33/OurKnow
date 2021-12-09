class CommentsController < ApplicationController
  def create
    @knowledge = Knowledge.find(params[:knowledge_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.knowledge_id = @knowledge.id
    if @comment.save
      @comments = Comment.where(knowledge_id: @knowledge.id).page(params[:page]).per(20)
    else
      @knowledge = Knowledge.find_by(id: @knowledge.id)
      @comments = Comment.where(knowledge_id: @knowledge.id).page(params[:page]).per(20)
    end
  end

  def destroy
    @knowledge = Knowledge.find(params[:knowledge_id])
    @comments = Comment.where(knowledge_id: @knowledge.id).page(params[:page]).per(20)
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.permit(:content)
  end
end
