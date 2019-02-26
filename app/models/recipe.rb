class Recipe < ApplicationRecord
    belongs_to :user
    acts_as_commentable
    is_impressionable

    def self.search(search)
        # for i in 1..10
        where("title || content1 ||content2||content3||content4||content5||content6||content7||content8||content9||content10 LIKE ?", "%#{search}%")     
    end
end
