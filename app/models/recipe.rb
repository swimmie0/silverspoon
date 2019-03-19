class Recipe < ApplicationRecord
    belongs_to :user
    acts_as_commentable
    is_impressionable

    acts_as_followable

    mount_uploader :recipeimage0, S3Uploader
    mount_uploader :recipeimage1, S3Uploader
    mount_uploader :recipeimage2, S3Uploader
    mount_uploader :recipeimage3, S3Uploader
    mount_uploader :recipeimage4, S3Uploader
    mount_uploader :recipeimage5, S3Uploader
    mount_uploader :recipeimage6, S3Uploader
    mount_uploader :recipeimage7, S3Uploader
    mount_uploader :recipeimage8, S3Uploader
    mount_uploader :recipeimage9, S3Uploader
    mount_uploader :recipeimage10, S3Uploader


    def self.search(key)
        # for i in 1..10
        where("allergyfor || title|| explain LIKE ?", "%#{key}%")    
    end
end
