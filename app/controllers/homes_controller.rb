class HomesController < ApplicationController
  skip_before_action  :require_sign_in!
  def top
  end
  
  # ブックマーク一覧
  def myknow
    @bookmarks = Bookmark.where(user_id: current_user.id)
    # それぞれのブックマークに対応する知識を集める
    @knowledges = []
    @bookmarks.each do |bookmark|
      knowledge = bookmark.knowledge
      @knowledges.push(knowledge)
    end

  end
end
