class Notice < ApplicationRecord
    belongs_to :user
    acts_as_commentable
    is_impressionable

    def time(post)
        if Time.now.strftime("%m:%d") == post.created_at.strftime("%m:%d")
          post.created_at.strftime("%H:%m")
        else
          post.created_at.strftime("%m-%d")
        end
    end  
end
