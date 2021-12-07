class User < ApplicationRecord

  validates :mail, presence: true, uniqueness: true
end
