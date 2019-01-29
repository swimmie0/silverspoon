class Restaurant < ApplicationRecord
    mount_uploader :image, S3Uploader
   
    has_many :zizuminfos
    has_many :menus

    validates :restaurant_name, :uniqueness => true
    #acts_as_followable

    def self.RestaurantName
        if Restaurant.where(restaurant_name: "서브웨이")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "서브웨이"
            r.save
        end

        if Restaurant.where(restaurant_name: "맘스터치")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "맘스터치"
            r.save
        end

        if Restaurant.where(restaurant_name: "빕스")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "빕스"
            r.save
        end

        if Restaurant.where(restaurant_name: "라라코스트")[0].nil?
            r = Restaurant.new
            r.restaurant_name = "라라코스트"
            r.save
        end
    end

end

