class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :knowledge
  
  validates :user_id, uniqueness: {scope: :knowledge_id}
end
