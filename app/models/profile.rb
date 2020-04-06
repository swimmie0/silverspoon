class Profile < ApplicationRecord
  
  acts_as_followable

  belongs_to :user, dependent: :destroy
  validates :user_id, uniqueness: true

  def image(user)
    if user.profileimg.url == nil
      user.profileimg = 'defaultImg3.jpg'  
    else
      user.profileimg.url
    end
  end

  # def image(zizum)
  #   if zizum.restaurant.image.url == nil
  #       zizum.restaurant.image.url = "beige-logo.PNG"
  #   else
  #       zizum.restaurant.image.url
  #   end
  # end

end
