class Knowledge < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorites ,dependent: :destroy
  
  
  validates :content, presence: true
  
  # current_userがブックマークしているかそうでないかでviewを変える
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user).exists?
  end
end
