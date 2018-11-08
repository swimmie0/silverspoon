class Freeboard < ApplicationRecord
  belongs_to :user
  acts_as_commentable
end
