class User < ApplicationRecord

  validates :mail, presence: true, uniqueness: true
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :knowledges, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :entries, dependent: :destroy

   attachment :image
end
