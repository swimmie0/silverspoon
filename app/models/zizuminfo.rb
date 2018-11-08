class Zizuminfo < ApplicationRecord
    mount_uploader :image, S3Uploader
    
    belongs_to :restaurant

    validates :zizum_name, :uniqueness => true

    acts_as_followable

    #서브웨이
    def self.Subway
        #restaurant table 상 본점 id
        r_id = Restaurant.where(restaurant_name: "서브웨이")[0].id

        for pageNum in 1..34
            url = "http://subway.co.kr/storeSearch?page="+"#{pageNum}"+"&rgn1Nm=&rgn2Nm=#storeList"
            data = Nokogiri::HTML(open(url))
            rows = data.css('tbody tr')

            rows.each do |r|
                #매장이름
                zizum_name = r.css(':nth-child(2)').text
                
                #지점 정보가 없을 경우에는 재생성,있을 경우에는 update
                zizum = Zizuminfo.where(restaurant_name: "서브웨이", zizum_name: zizum_name)[0]

                if zizum.nil?
                    zizum = Zizuminfo.new
                end

                #본점이름
                zizum.restaurant_name = "서브웨이"
                zizum.restaurant_id = r_id

                #매장이름
                zizum.zizum_name = zizum_name
                
                #매장주소
                juso = r.css(':nth-child(3)').text
                split_juso = juso.split(" ")
                split_number = split_juso.count

                zizum.sido = split_juso[0]
                zizum.sigungu = split_juso[1]

                zizum.sangse_juso = split_juso[2]
                
                for i in 3..split_number-1
                    zizum.sangse_juso += " " + split_juso[i]
                end
                
                #전화번호
                phone_number = r.css(':nth-child(5)').text
                if zizum.phone_number != "Coming Soon"
                    zizum.phone_number = phone_number
                else
                    zizum.phone_number = "전화번호가 없습니다"
                end
                
                zizum.save
            end
        end
    end

    #맘스터치
    def self.Momstouch
        #restaurant table 상 본점 id
        r_id = Restaurant.where(restaurant_name: "맘스터치")[0].id

        for pageNum in 1..115
            url = "http://www.momstouch.co.kr/sub/store/store_01_list.html?pg="+"#{pageNum}"+"&area=&ss="
            data = Nokogiri::HTML(open(url))
            #rows = data.css('table')[2].css('tbody tr :not(:nth-child(1))'.)
            rows = data.css('.store_List tr:not(:nth-of-type(1))')
        
            rows.each do |r|
                #매장이름
                zizum_name = r.css(':nth-child(2)').text
                
                #지점 정보가 없을 경우에는 재생성,있을 경우에는 update
                zizum = Zizuminfo.where(restaurant_name: "맘스터치", zizum_name: zizum_name)[0]

                if zizum.nil?
                    zizum = Zizuminfo.new
                end

                #본점이름
                zizum.restaurant_name = "맘스터치"
                zizum.restaurant_id = r_id

                #매장이름
                zizum.zizum_name = zizum_name
                
                #매장주소
                juso = r.css(':nth-child(3)').text
                split_juso = juso.split(" ")
                split_number = split_juso.count

                zizum.sido = split_juso[0]
                zizum.sigungu = split_juso[1]

                zizum.sangse_juso = split_juso[2]
                
                for i in 3..split_number-1
                    zizum.sangse_juso += " " + split_juso[i]
                end
                
                #전화번호
                zizum.phone_number = r.css(':nth-child(4)').text
                
                zizum.save
            end
        end
    end

    #한솥

    # if !Zizuminfo.exists?(restaurant_name: "서브웨이")
    #     self.Subway
    # end

    # if !Zizuminfo.exists?(restaurant_name: "맘스터치")
    #     self.Momstouch
    # end
end
