class Profile < ApplicationRecord
  
  acts_as_followable

  belongs_to :user, dependent: :destroy
  validates :user_id, uniqueness: true
end
