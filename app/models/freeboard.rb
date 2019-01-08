class Freeboard < ApplicationRecord
  belongs_to :user
  acts_as_commentable
  is_impressionable

  def self.search(search)
    where("title || content LIKE ?", "%#{search}%") 
  end
end
