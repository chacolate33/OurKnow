class User < ApplicationRecord

  validates :mail, presence: true, uniqueness: true
  has_many :group_users
  has_many :groups, through: :group_users
end
