class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  has_many :boards

  acts_as_follower

  mount_uploader :profileimg, S3Uploader
  
  # GENDER_TYPES = [ ["male","0"], [ "female","1" ] ]
  # validates_inclusion_of :is_female, in: [true, false]

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # user와 identity가 nil이 아니라면 받는다
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    # user가 nil이라면 새로 만든다
    if user.nil?
      # 이미 있는 이메일인지 확인한다
      email = auth.info.email
      user = User.where(:email => email).first
      unless self.where(email: auth.info.email).exists?
        # 없다면 새로운 데이터를 생성한다
        if user.nil?
          # provider(회사)별로 데이터를 제공해주는 hash의 이름이 다름. omnaiuth별로 auth hash가 어떤 경로로, 이름으로 제공되는지 확인하고 설정해야ㅏㅁ.
          # 카카오는 email을 제공하지 않음 
            if auth.provider == "kakao"
              user = User.new(
                profileimg: auth.info.image,
                # remote_profileimage_url: auth.info.image.gsub('http://','https://'),
                name: auth.info.name,
                password: Devise.friendly_token[0,20]
              )
            elsif auth.provider == "google_oauth2"
              user = User.new(
                email: auth.info.email,
                name: auth.info.name,                
                gender: auth.extra.raw_info.gender,
                # is_female: auth.extra.raw_info.gender == "female" ? false : true,                              
                profileimg: auth.info.image,
                password: Devise.friendly_token[0,20]
              )
              elsif auth.provider == "naver"  
                user = User.new(
                  email: auth.info.email,
                  name: auth.info.name,                
                  gender: auth.extra.raw_info.response.gender = "F" ? "female" : "male", #nil값인경우..
                  ages: auth.extra.raw_info.response.age,
                  profileimg: auth.info.image,
                  password: Devise.friendly_token[0,20]
                )
            end
          user.save!
        end #if
      end #unless
    end  

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  # email이 없어도 가입이 되도록 설정
  def email_required?
    false
  end

  ## for current password문제
  #to remove the current password check if updating a profile originally gotten via oauth (fb, twitter)
  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:current_password)
      self.update_without_password(params)
    else
      self.verify_password_and_update(params)
    end
  end

  def update_without_password(params={})
    params.delete(:password)
    params.delete(:password_confirmation)
    result = update_attributes(params)
    clean_up_passwords
    result
  end

  def verify_password_and_update(params)
    #devises' update_with_password 
    # https://github.com/plataformatec/devise/blob/master/lib/devise/models/database_authenticatable.rb
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
      update_attributes(params)
    else
      self.attributes = params
      self.valid?
      self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
      false
    end

    clean_up_passwords
    result
  end

  before_save do
    self.allergy.gsub!(/[\[\]\"]/, '') if attribute_present?("allergy")
    # self.allergy = "#{allergy}, #{etc}"    
  end
  before_update do
    self.allergy = "#{allergy} #{allergy_etc}"    
  end  

end
