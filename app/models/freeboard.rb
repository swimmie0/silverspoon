class Freeboard < ApplicationRecord
  belongs_to :user
  # validates :user_id, uniqueness: true

  acts_as_commentable
  is_impressionable
  
  def self.category(category)
    where("category LIKE ?", "%#{category}%") 
  end

  def self.search(search)
    where("title || content || name LIKE ?", "%#{search}%") 
  end

  def image(writer)
    if writer.profileimg.url == nil
      writer.profileimg = 'defaultImg3.jpg'  
    else
      writer.profileimg.url
    end
  end

  def time(post)
    if Time.now.strftime("%m:%d") == post.created_at.strftime("%m:%d")
      post.created_at.strftime("%H:%m")
    else
      post.created_at.strftime("%m-%d")
    end
  end  
end
