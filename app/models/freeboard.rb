class Freeboard < ApplicationRecord
  belongs_to :user
  acts_as_commentable
  is_impressionable

  def self.search(search)
    where("title || content LIKE ?", "%#{search}%") 
  end
  
  # def self.completed(completed)
  #   if params[:completed] == true
  #       Free.completed == true
  #   end
  # end

  def self.category(category)
    where("category LIKE ?", "%#{category}%") 
  end

  def time(post)
    if Time.now.strftime("%m:%d") == post.created_at.strftime("%m:%d")
      post.created_at.strftime("%H:%m")
    else
      post.created_at.strftime("%m-%d")
    end
  end  
end
