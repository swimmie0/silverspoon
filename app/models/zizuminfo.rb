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
                sido = split_juso[0]

                if sido == "서울특별시" || sido =="서울" || sido =="서울시"
                    sido = "서울특별시"
                elsif sido =="부산광역시" || sido =="부산" || sido == "부산시"
                    sido = "부산광역시"
                elsif sido =="대구광역시" || sido =="대구" || sido == "대구시"
                    sido = "대구광역시"
                elsif sido =="인천광역시" || sido =="인천" || sido == "인천시"
                    sido = "인천광역시"
                elsif sido =="광주광역시" || sido =="광주" || sido == "광주시"
                    sido = "광주광역시"
                elsif sido =="대전광역시" || sido =="대전" || sido == "대전시"
                    sido = "대전광역시"
                elsif sido =="세종특별자치시" || sido =="세종" || sido == "세종시"
                    sido = "세종특별자치시"
                elsif sido =="경기도" || sido =="경기"
                    sido = "경기도"
                elsif sido =="강원도" || sido =="강원"
                    sido = "강원도"
                elsif sido =="충청북도" || sido =="충북"
                    sido = "충청북도"
                elsif sido =="충청남도" || sido =="충남"
                    sido = "충청남도"
                elsif sido =="전라남도" || sido =="전남"
                    sido = "전라남도"
                elsif sido =="전라북도" || sido =="전북"
                    sido = "전라북도"
                elsif sido =="경상남도" || sido =="경남"
                    sido = "경상남도"
                elsif sido =="경상북도" || sido =="경북"
                    sido = "경상북도"
                elsif sido =="제주특별자치시" || sido =="제주시" ||sido =="제주" ||sido =="제주도" ||sido ="제주특별자치도"
                    sido = "제주특별자치시"
                end

                zizum.sido = sido
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
                sido = split_juso[0]
                
                if sido == "서울특별시" || sido =="서울" || sido =="서울시"
                    sido = "서울특별시"
                elsif sido =="부산광역시" || sido =="부산" || sido == "부산시"
                    sido = "부산광역시"
                elsif sido =="대구광역시" || sido =="대구" || sido == "대구시"
                    sido = "대구광역시"
                elsif sido =="인천광역시" || sido =="인천" || sido == "인천시"
                    sido = "인천광역시"
                elsif sido =="광주광역시" || sido =="광주" || sido == "광주시"
                    sido = "광주광역시"
                elsif sido =="대전광역시" || sido =="대전" || sido == "대전시"
                    sido = "대전광역시"
                elsif sido =="세종특별자치시" || sido =="세종" || sido == "세종시"
                    sido = "세종특별자치시"
                elsif sido =="경기도" || sido =="경기"
                    sido = "경기도"
                elsif sido =="강원도" || sido =="강원"
                    sido = "강원도"
                elsif sido =="충청북도" || sido =="충북"
                    sido = "충청북도"
                elsif sido =="충청남도" || sido =="충남"
                    sido = "충청남도"
                elsif sido =="전라남도" || sido =="전남"
                    sido = "전라남도"
                elsif sido =="전라북도" || sido =="전북"
                    sido = "전라북도"
                elsif sido =="경상남도" || sido =="경남"
                    sido = "경상남도"
                elsif sido =="경상북도" || sido =="경북"
                    sido = "경상북도"
                elsif sido =="제주특별자치시" || sido =="제주시" ||sido =="제주" ||sido =="제주도" ||sido ="제주특별자치도"
                    sido = "제주특별자치시"
                end

                zizum.sido = sido
                
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

    #빕스
    def self.Vips
        #restaurant table 상 본점 id
        r_id = Restaurant.where(restaurant_name: "빕스")[0].id

        for pageNum in 1..7
            url = "https://www.ivips.co.kr:7002/store/storeStoreInfoQ.asp?pageseq="+"#{pageNum}"
            data = Nokogiri::HTML(open(url))
            rows = data.css('table tbody tr')

            rows.drop(2).each do |r|
                #매장이름
                zizum_name = r.css('td:nth-child(1)').text
                
                #지점 정보가 없을 경우에는 재생성,있을 경우에는 update
                zizum = Zizuminfo.where(restaurant_name: "빕스", zizum_name: zizum_name)[0]

                if zizum.nil?
                    zizum = Zizuminfo.new
                end

                #본점이름
                zizum.restaurant_name = "빕스"
                zizum.restaurant_id = r_id

                #매장이름
                zizum.zizum_name = zizum_name
                
                #매장주소
                juso = r.css('td:nth-child(3)').text

                ###제공주소 한개일때 (디폴트는 두개: 도로명주소와 지번주소)
                if juso.split(':').count == 1         
                    split_juso = juso.split(':')[0].split(" ")  #[]
                    sangse_juso = split_juso.drop(2).join(" ")  #시군구빼고
                else 
                    split_juso = juso.split(':')[2].split(" ")  #[]
                    extra = juso.split(':')[1].split(" ").reverse.drop(1).reverse.join(" ") #도로명주소select
                    sangse_juso = split_juso.drop(2).join(" ") + " (도로명 주소: " + extra + ")" #시군구빼고 + 도로명주소                
                end

                zizum.sangse_juso = sangse_juso

                sido = split_juso[0]

                if sido == "서울특별시" || sido =="서울" || sido =="서울시"
                    sido = "서울특별시"
                elsif sido =="부산광역시" || sido =="부산" || sido == "부산시"
                    sido = "부산광역시"
                elsif sido =="대구광역시" || sido =="대구" || sido == "대구시"
                    sido = "대구광역시"
                elsif sido =="인천광역시" || sido =="인천" || sido == "인천시"
                    sido = "인천광역시"
                elsif sido =="광주광역시" || sido =="광주" || sido == "광주시"
                    sido = "광주광역시"
                elsif sido =="대전광역시" || sido =="대전" || sido == "대전시"
                    sido = "대전광역시"
                elsif sido =="세종특별자치시" || sido =="세종" || sido == "세종시"
                    sido = "세종특별자치시"
                elsif sido =="경기도" || sido =="경기"
                    sido = "경기도"
                elsif sido =="강원도" || sido =="강원"
                    sido = "강원도"
                elsif sido =="충청북도" || sido =="충북"
                    sido = "충청북도"
                elsif sido =="충청남도" || sido =="충남"
                    sido = "충청남도"
                elsif sido =="전라남도" || sido =="전남"
                    sido = "전라남도"
                elsif sido =="전라북도" || sido =="전북"
                    sido = "전라북도"
                elsif sido =="경상남도" || sido =="경남"
                    sido = "경상남도"
                elsif sido =="경상북도" || sido =="경북"
                    sido = "경상북도"
                elsif sido =="제주특별자치시" || sido =="제주시" ||sido =="제주" ||sido =="제주도" ||sido ="제주특별자치도"
                    sido = "제주특별자치시"
                end

                zizum.sido = sido
                zizum.sigungu = split_juso[1]
                
                #전화번호
                zizum.phone_number = r.css('td:nth-child(2)').text

                zizum.save
            end
        end
    end

    #라라코스트
    def self.Raracost
        #restaurant table 상 본점 id
        r_id = Restaurant.where(restaurant_name: "라라코스트")[0].id

        for pageNum in 1..14
            url = "http://www.raracost.com/pg/bbs/board.php?bo_table=Nstore&page="+"#{pageNum}"
            data = Nokogiri::HTML(open(url,'r:binary').read) 
            rows = data.css('table.board_list tr')

            rows.drop(1).each do |r|
                #매장이름
                zizum_name = r.css('td.subject').text
                
                #지점 정보가 없을 경우에는 재생성,있을 경우에는 update
                zizum = Zizuminfo.where(restaurant_name: "빕스", zizum_name: zizum_name)[0]

                if zizum.nil?
                    zizum = Zizuminfo.new
                end

                #본점이름
                zizum.restaurant_name = "라라코스트"
                zizum.restaurant_id = r_id

                #매장이름
                zizum.zizum_name = zizum_name
                
                #매장주소
                juso = r.css('td.add').text
                split_juso = juso.split(" ")
                sangse_juso = split_juso.drop(2).join(" ")

                sido = split_juso[0]

                if sido == "서울특별시" || sido =="서울" || sido =="서울시"
                    sido = "서울특별시"
                elsif sido =="부산광역시" || sido =="부산" || sido == "부산시"
                    sido = "부산광역시"
                elsif sido =="대구광역시" || sido =="대구" || sido == "대구시"
                    sido = "대구광역시"
                elsif sido =="인천광역시" || sido =="인천" || sido == "인천시"
                    sido = "인천광역시"
                elsif sido =="광주광역시" || sido =="광주" || sido == "광주시"
                    sido = "광주광역시"
                elsif sido =="대전광역시" || sido =="대전" || sido == "대전시"
                    sido = "대전광역시"
                elsif sido =="세종특별자치시" || sido =="세종" || sido == "세종시"
                    sido = "세종특별자치시"
                elsif sido =="경기도" || sido =="경기"
                    sido = "경기도"
                elsif sido =="강원도" || sido =="강원"
                    sido = "강원도"
                elsif sido =="충청북도" || sido =="충북"
                    sido = "충청북도"
                elsif sido =="충청남도" || sido =="충남"
                    sido = "충청남도"
                elsif sido =="전라남도" || sido =="전남"
                    sido = "전라남도"
                elsif sido =="전라북도" || sido =="전북"
                    sido = "전라북도"
                elsif sido =="경상남도" || sido =="경남"
                    sido = "경상남도"
                elsif sido =="경상북도" || sido =="경북"
                    sido = "경상북도"
                elsif sido =="제주특별자치시" || sido =="제주시" ||sido =="제주" ||sido =="제주도" ||sido ="제주특별자치도"
                    sido = "제주특별자치시"
                end

                zizum.sido = sido
                zizum.sigungu = split_juso[1]
                zizum.sangse_juso = sangse_juso
                
                #전화번호
                zizum.phone_number = r.css('td.name1').text

                zizum.save
            end
        end
    end

    def self.Coffeebean
        r_id = Restaurant.where(restaurant_name: "커피빈")[0].id
        zizum_name = "커피빈"

        zizum = Zizuminfo.where(restaurant_name: "커피빈", zizum_name: zizum_name)[0]
        if zizum.nil?
            zizum = Zizuminfo.new
        end

        zizum.restaurant_name = "커피빈"
        zizum.restaurant_id = r_id
        zizum.zizum_name = zizum_name
        zizum.save
    end
    
    def self.Popeyes
        r_id = Restaurant.where(restaurant_name: "파파이스")[0].id
        zizum_name = "파파이스"

        zizum = Zizuminfo.where(restaurant_name: "파파이스", zizum_name: zizum_name)[0]
        if zizum.nil?
            zizum = Zizuminfo.new
        end

        zizum.restaurant_name = "파파이스"
        zizum.restaurant_id = r_id
        zizum.zizum_name = zizum_name
        zizum.save
    end

    def self.Baskin
        r_id = Restaurant.where(restaurant_name: "배스킨라빈스")[0].id
        zizum_name = "배스킨라빈스"

        zizum = Zizuminfo.where(restaurant_name: "배스킨라빈스", zizum_name: zizum_name)[0]
        if zizum.nil?
            zizum = Zizuminfo.new
        end

        zizum.restaurant_name = "배스킨라빈스"
        zizum.restaurant_id = r_id
        zizum.zizum_name = zizum_name
        zizum.save
    end

    def self.Burgerking
        r_id = Restaurant.where(restaurant_name: "버거킹")[0].id
        zizum_name = "버거킹"

        zizum = Zizuminfo.where(restaurant_name: "버거킹", zizum_name: zizum_name)[0]
        if zizum.nil?
            zizum = Zizuminfo.new
        end

        zizum.restaurant_name = "버거킹"
        zizum.restaurant_id = r_id
        zizum.zizum_name = zizum_name
        zizum.save
    end

    #한솥

    # if !Zizuminfo.exists?(restaurant_name: "서브웨이")
    #     self.Subway
    # end

    # if !Zizuminfo.exists?(restaurant_name: "맘스터치")
    #     self.Momstouch
    # end
end
