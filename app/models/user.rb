class User < ApplicationRecord

  validates :mail, presence: true, uniqueness: true
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :knowledges, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :favoites, dependent: :destroy
  
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

   attachment :image
   
    # フォロー機能
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外す機能
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローする/外すボタンの表示を分けるための記載
  def following?(user)
    followings.include?(user)
  end
end
