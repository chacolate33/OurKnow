class BookmarksController < ApplicationController
  def create
    @knowledge = Knowledge.find(params[:knowledge_id])
    bookmark = Bookmark.new(user_id: current_user.id, knowledge_id: @knowledge.id)
    bookmark.save
    redirect_to request.referer
  end

  def destroy
    @knowledge = Knowledge.find(params[:knowledge_id])
    bookmark = Bookmark.find_by(user_id: current_user.id, knowledge_id: @knowledge.id)
    bookmark.destroy
    redirect_to request.referer
  end
end
