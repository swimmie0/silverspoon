class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy

  validates :user_id, uniqueness: true
end
