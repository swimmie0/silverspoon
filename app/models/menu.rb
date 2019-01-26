require 'open-uri'
require 'nokogiri'

class Menu < ApplicationRecord
    mount_uploader :image, S3Uploader

    belongs_to :restaurant
    
    validates :menu_name, :uniqueness => true

    def self.Subway
        #서브웨이
        url = "http://subway.co.kr/sandwichAllergy"
        data = Nokogiri::HTML(open(url))
        rows = data.css('tbody tr')

        rows.each do |r|
            m_name = r.css('th').text
            r_name = "서브웨이"
            
            if Menu.where(menu_name: m_name)[0].nil?
                a_info = Menu.new
            else
                a_info = Menu.where(restaurant_name: r_name, menu_name: m_name)[0]
            end

            #레스토랑
            a_info.restaurant_name = r_name
            a_info.restaurant_id = Restaurant.where(restaurant_name: r_name)[0].id

            #메뉴 이름
            a_info.menu_name = m_name

            #계란 / 생선 / 우유,락토스 / 땅콩 / 참깨 / 조개류 / 대두,콩 / 견과류 / 밀,글루텐 / 아황산류 / 아질산염,질산염            
            #계란 9
            a = r.css(':nth-child(2)')
            if a.css('span').empty?
                a_info.a9_nanryu = 0
            elsif a.css('span').attr('class').text == "a01"
                a_info.a9_nanryu = 1
            elsif a.css('span').attr('class').text == "a02"
                a_info.a9_nanryu = -2
            end

            #생선. 우리 표에 없음
            # a = r.css(':nth-child(3)')
            # if a.css('span').empty?             
            # elsif a.css('span').attr('class').text == "a01"
            # elsif a.css('span').attr('class').text == "a02"
            # end

            #우유,락토스 10
            a = r.css(':nth-child(4)')
           
            if a.css('span').empty?
                a_info.a10_milk = 0
            elsif a.css('span').attr('class').text == "a01"
                a_info.a10_milk = 1   
            elsif a.css('span').attr('class').text == "a02"
                a_info.a10_milk = -2
            end

            #땅콩 5
            a = r.css(':nth-child(5)')
            if a.css('span').empty?
                a_info.a5_ddangkong = 0
            elsif a.css('span').attr('class').text == "a01"
                a_info.a5_ddangkong = 1   
            elsif a.css('span').attr('class').text == "a02"
                a_info.a5_ddangkong = -2
            end

            #참깨 5  테이블 상에 존재하지 않음
            # a = r.css(':nth-child(6)')
            # if a.css('span').empty?
            #     a_info.a5_ddangkong = 0
            # elsif a.css('span').attr('class').text == "a01"
            #     a_info.a5_ddangkong = 1   
            # elsif a.css('span').attr('class').text == "a02"
            #     a_info.a5_ddangkong = -2
            # end

            #조개 18
            a = r.css(':nth-child(7)')
            if a.css('span').empty?
                a_info.a18_jogaeryu = 0
            elsif a.css('span').attr('class').text == "a01"
                a_info.a18_jogaeryu = 1
            elsif a.css('span').attr('class').text == "a02"
                a_info.a18_jogaeryu = -2
            end

            #대두,콩 3
            a = r.css(':nth-child(8)')
            if a.css('span').empty?
                a_info.a3_daedu = 0
            elsif a.css('span').attr('class').text == "a01"
                a_info.a3_daedu = 1
            elsif a.css('span').attr('class').text == "a02"
                a_info.a3_daedu = -2
            end

            #견과류 (호두 4)
            a = r.css(':nth-child(9)')
            if a.css('span').empty?
                a_info.a4_hodu = 0
            elsif a.css('span').attr('class').text == "a01"
                a_info.a4_hodu = 1
            elsif a.css('span').attr('class').text == "a02"
                a_info.a4_hodu = -2
            end


            #밀 2
            a = r.css(':nth-child(10)')
            if a.css('span').empty?
                a_info.a2_mil = 0
            elsif a.css('span').attr('class').text == "a01"
                a_info.a2_mil = 1
            elsif a.css('span').attr('class').text == "a02"
                a_info.a2_mil = -2
            end

            #아황산류 21
            a = r.css(':nth-child(11)')
            if a.css('span').empty?
                a_info.a21_ahwangsan = 0
            elsif a.css('span').attr('class').text == "a01"
                a_info.a21_ahwangsan = 1
            elsif a.css('span').attr('class').text == "a02"
                a_info.a21_ahwangsan = -2
            end
     
            #미제공 항목
            a_info.a1_maemil = -1
            a_info.a6_peach = -1
            a_info.a7_tomato = -1
            a_info.a8_piggogi = -1
            a_info.a11_ddakgogi = -1
            a_info.a12_shoigogi = -1
            a_info.a13_saewoo = -1
            a_info.a14_godeungeoh = -1
            a_info.a15_honghap = -1
            a_info.a16_junbok = -1
            a_info.a17_gul = -1
            a_info.a19_gye = -1
            a_info.a20_ohjingeoh = -1

            a_info.save
        end
    end

    def self.Momstouch
        url = "http://momstouch.co.kr/ale.html"
        data = Nokogiri::HTML(open(url))
        rows = data.css('.table_allergy tbody tr')

        rows.each do |r|
            r_name = "맘스터치"
            m_name = r.css(':nth-child(1)').text
            
            if Menu.where(menu_name: m_name)[0].nil?
                a_info = Menu.new
            else
                a_info = Menu.where(restaurant_name: r_name, menu_name: m_name)[0]
            end

            #레스토랑
            a_info.restaurant_name = r_name
            a_info.restaurant_id = Restaurant.where(restaurant_name: r_name)[0].id

            #메뉴 이름
            a_info.menu_name = m_name

            #메밀 1
            a = r.css(':nth-child(4)').text

            if a == "○"
                a_info.a1_maemil = 1
            elsif a == "·"
                a_info.a1_maemil = 0
            end

            #밀 2
            a = r.css(':nth-child(7)').text

            if a == "○"
                a_info.a2_mil = 1
            elsif a == "·"
                a_info.a2_mil = 0
            end
            #대두 3
            a = r.css(':nth-child(6)').text

            if a == "○"
                a_info.a3_daedu = 1
            elsif a == "·"
                a_info.a3_daedu = 0
            end
            #호두 4
            a = r.css(':nth-child(15)').text

            if a == "○"
                a_info.a4_hodu= 1
            elsif a == "·"
                a_info.a4_hodu = 0
            end
            #땅콩 5
            a = r.css(':nth-child(5)').text

            if a == "○"
                a_info.a5_ddangkong = 1
            elsif a == "·"
                a_info.a5_ddangkong = 0
            end

            #복숭아	6
            a = r.css(':nth-child(12)').text

            if a == "○"
                a_info.a6_peach = 1
            elsif a == "·"
                a_info.a6_peach = 0
            end

            #토마토	7
            a = r.css(':nth-child(13)').text

            if a == "○"
                a_info.a7_tomato = 1
            elsif a == "·"
                a_info.a7_tomato = 0
            end
            #돼지고기 8
            a = r.css(':nth-child(11)').text

            if a == "○"
                a_info.a8_piggogi = 1
            elsif a == "·"
                a_info.a8_piggogi = 0
            end

            #난류 9
            a = r.css(':nth-child(2)').text

            if a == "○"
                a_info.a9_nanryu = 1
            elsif a == "·"
                a_info.a9_nanryu = 0
            end

            #우유 10	
            a = r.css(':nth-child(3)').text

            if a == "○"
                a_info.a10_milk = 1
            elsif a == "·"
                a_info.a10_milk = 0
            end
            #닭고기	11
            a = r.css(':nth-child(16)').text

            if a == "○"
                a_info.a11_ddakgogi = 1
            elsif a == "·"
                a_info.a11_ddakgogi = 0
            end
            #쇠고기	12
            a = r.css(':nth-child(17)').text

            if a == "○"
                a_info.a12_shoigogi = 1
            elsif a == "·"
                a_info.a12_shoigogi = 0
            end
            #새우 13
            a = r.css(':nth-child(10)').text

            if a == "○"
                a_info.a13_saewoo = 1
            elsif a == "·"
                a_info.a13_saewoo = 0
            end
            #고등어	14
            a = r.css(':nth-child(8)').text

            if a == "○"
                a_info.a14_godeungeoh = 1
            elsif a == "·"
                a_info.a14_godeungeoh = 0
            end
            #조개류 18
            a = r.css(':nth-child(19)').text

            if a == "○"
                a_info.a18_jogaeryu = 1
            elsif a == "·"
                a_info.a18_jogaeryu = 0
            end
            #게 19
            a = r.css(':nth-child(9)').text

            if a == "○"
                a_info.a19_gye = 1
            elsif a == "·"
                a_info.a19_gye = 0
            end
            #오징어	20          
            a = r.css(':nth-child(18)').text

            if a == "○"
                a_info.a20_ohjingeoh = 1
            elsif a == "·"
                a_info.a20_ohjingeoh = 0
            end
            #아황산류* 21	            
            a = r.css(':nth-child(14)').text

            if a == "○"
                a_info.a21_ahwangsan = 1
            elsif a == "·"
                a_info.a21_ahwangsan = 0
            end
            
            #제공하지 않음
            a_info.a15_honghap = -1
            a_info.a16_junbok  = -1
            a_info.a17_gul  = -1
            
            a_info.save
        end
        
    end

    # def self.Hansot
    #     # 한솥
    #     for pageNum in 2..119
    #         if pageNum == 7
    #             # 7, 9, 12, 18, 23, 28, 30, 35, 36, 37, 38, 41, 43, 44, 53, 58, 59, 60, 61, 62, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 84, 85, 87, 88, 89, 90, 94, 95, 96, 105, 106, 107, 108, 109, 111, 112, 114, 115, 118
    #             next
    #         elsif pageNum == 9
    #             next
    #         elsif pageNum == 12
    #             next
    #         elsif pageNum == 18
    #             next
    #         elsif pageNum == 23
    #             next
    #         elsif pageNum == 28
    #             next
    #         elsif pageNum == 30
    #             next
    #         elsif pageNum == 35
    #             next
    #         elsif pageNum == 36
    #             next
    #         elsif pageNum == 37
    #             next
    #         elsif pageNum == 38
    #             next
    #         elsif pageNum == 41
    #             next
    #         elsif pageNum == 43
    #             next
    #         elsif pageNum == 44
    #             next
    #         elsif pageNum == 53
    #             next
    #         elsif pageNum == 58
    #             next
    #         elsif pageNum == 59
    #             next
    #         elsif pageNum == 60
    #             next
    #         elsif pageNum == 61
    #             next
    #         elsif pageNum == 62
    #             next
    #         elsif pageNum == 69
    #             next
    #         elsif pageNum == 70
    #             next
    #         elsif pageNum == 71
    #             next
    #         elsif pageNum == 72
    #             next
    #         elsif pageNum == 73
    #             next
    #         elsif pageNum == 74
    #             next
    #         elsif pageNum == 75
    #             next
    #         elsif pageNum == 76
    #             next
    #         elsif pageNum == 77
    #             next
    #         elsif pageNum == 78
    #             next
    #         elsif pageNum == 79
    #             next
    #         elsif pageNum == 80
    #             next
    #         elsif pageNum == 81
    #             next
    #         elsif pageNum == 84
    #             next
    #         elsif pageNum == 85
    #             next
    #         elsif pageNum == 87
    #             next
    #         elsif pageNum == 88
    #             next
    #         elsif pageNum == 89
    #             next
    #         elsif pageNum == 90
    #             next
    #         elsif pageNum == 94
    #             next
    #         elsif pageNum == 95
    #             next
    #         elsif pageNum == 96
    #             next
    #         elsif pageNum == 100
    #             # 한솥볶음고추장 얘네 따로 해야 됨.
    #             # 알레르기 해당 사항 없음.

    #             url = "https://www.hsd.co.kr/menu/menu_view/100?cate1=2&cate2=24"

    #             data = Nokogiri::HTML(open(url))
    #             rows = data.css('body') 
    
    #             rows.each do |r|
    #                 m_name = r.css(".he_tit//.dp2").inner_text

    #                 if Menu.where(menu_name: m_name)[0].nil?
    #                     a_info = Menu.new
    #                 else
    #                     a_info = Menu.where(menu_name: m_name)[0]
    #                 end
                
    #                 a_info.restaurant_id = 3
    #                 a_info.restaurant_name = "한솥"
        
    #                 #메뉴 이름
    #                 a_info.menu_name = m_name
    #                 #list_01 난류, 우유, 메밀 + list_02 땅콩, 대두, 밀 + list_03 고등어, 게, 돼지고기 + list_04 복숭아, 토마토, 새우 + list_05 아황산류, 호두, 닭고기 + list_06 쇠고기, 오징어, 조개류
    
    #                 a_info.a9_nanryu = -1
    #                 a_info.a10_milk = -1
    #                 a_info.a1_maemil = -1
    #                 a_info.a5_ddangkong = -1
    #                 a_info.a3_daedu = -1
    #                 a_info.a2_mil = -1
    #                 a_info.a14_godeungeoh = -1
    #                 a_info.a19_gye = -1
    #                 a_info.a8_piggogi = -1
    #                 a_info.a6_peach = -1
    #                 a_info.a7_tomato = -1
    #                 a_info.a13_saewoo = -1
    #                 a_info.a21_ahwangsan = -1
    #                 a_info.a4_hodu = -1
    #                 a_info.a11_ddakgogi = -1
    #                 a_info.a12_shoigogi = -1
    #                 a_info.a20_ohjingeoh = -1
    #                 a_info.a18_jogaeryu = -1
    #                 a_info.a15_honghap = -1
    #                 a_info.a16_junbok  = -1
    #                 a_info.a17_gul  = -1
                    
    #                 a_info.save
    #             end
    #             next   
    #         elsif pageNum == 105
    #             next
    #         elsif pageNum == 106
    #             next
    #         elsif pageNum == 107
    #             next
    #         elsif pageNum == 108
    #             next
    #         elsif pageNum == 109
    #             next
    #         elsif pageNum == 111
    #             next
    #         elsif pageNum == 112
    #             next
    #         elsif pageNum == 114
    #             next
    #         elsif pageNum == 115
    #             next
    #         elsif pageNum == 118
    #             next
    #         end

    #         url = "https://www.hsd.co.kr/menu/menu_view/#{pageNum}?cate1=2&cate2=24"

    #         data = Nokogiri::HTML(open(url))
    #         rows = data.css('body') 

    #         rows.each do |r|
    #             m_name = r.css(".he_tit//.dp2").inner_text # .he_tit
            
    #             if Menu.where(menu_name: m_name)[0].nil?
    #                 a_info = Menu.new
    #             else
    #                 a_info = Menu.where(menu_name: m_name)[0]
    #             end
    
    #             
                # #레스토랑
                # r_name = "한솥"
                # a_info.restaurant_name = r_name
                # a_info.restaurant_id = Restaurant.where(restaurant_name: r_name)[0].id

    
    #             #메뉴 이름
    #             a_info.menu_name = m_name
    #             #list_01 난류, 우유, 메밀 + list_02 땅콩, 대두, 밀 + list_03 고등어, 게, 돼지고기 + list_04 복숭아, 토마토, 새우 + list_05 아황산류, 호두, 닭고기 + list_06 쇠고기, 오징어, 조개류

    #             #list_01 난류, 우유, 메밀
    #             # 난류
    #             a = r.css(".allergy_wrap//.list_01//dl:nth-child(1)//span").inner_text
    #             # :nth-child(1)//dl:nth-child(1)//span

    #             if a == "포함"
    #                 a_info.a9_nanryu = 1
    #             elsif a == "불포함"
    #                 a_info.a9_nanryu = 0
    #             elsif a == "가공/제조"
    #                 a_info.a9_nanryu = -2
    #             end

    #             # 우유
    #             a = r.css(".allergy_wrap//.list_01//dl:nth-child(2)//span").inner_text

    #             if a == "포함"
    #                 a_info.a10_milk = 1
    #             elsif a == "불포함"
    #                 a_info.a10_milk = 0
    #             elsif a == "가공/제조"
    #                 a_info.a10_milk = -2
    #             end

    #             # 메밀
    #             a = r.css(".allergy_wrap//.list_01//dl:nth-child(3)//span").inner_text

    #             if a == "포함"
    #                 a_info.a1_maemil = 1
    #             elsif a == "불포함"
    #                 a_info.a1_maemil = 0
    #             elsif a == "가공/제조"
    #                 a_info.a1_maemil = -2
    #             end

    #             #list_02 땅콩, 대두, 밀
    #             # 땅콩
    #             a = r.css(".allergy_wrap//.list_02//dl:nth-child(1)//span").inner_text

    #             if a == "포함"
    #                 a_info.a5_ddangkong = 1
    #             elsif a == "불포함"
    #                 a_info.a5_ddangkong = 0
    #             elsif a == "가공/제조"
    #                 a_info.a5_ddangkong = -2
    #             end

    #             # 대두
    #             a = r.css(".allergy_wrap//.list_02//dl:nth-child(2)//span").inner_text

    #             if a == "포함"
    #                 a_info.a3_daedu = 1
    #             elsif a == "불포함"
    #                 a_info.a3_daedu = 0
    #             elsif a == "가공/제조"
    #                 a_info.a3_daedu = -2
    #             end

    #             # 밀
    #             a = r.css(".allergy_wrap//.list_02//dl:nth-child(3)//span").inner_text

    #             if a == "포함"
    #                 a_info.a2_mil = 1
    #             elsif a == "불포함"
    #                 a_info.a2_mil = 0
    #             elsif a == "가공/제조"
    #                 a_info.a2_mil = -2
    #             end

    #             #list_03 고등어, 게, 돼지고기
    #             # 고등어
    #             a = r.css(".allergy_wrap//.list_03//dl:nth-child(1)//span").inner_text

    #             if a == "포함"
    #                 a_info.a14_godeungeoh = 1
    #             elsif a == "불포함"
    #                 a_info.a14_godeungeoh = 0
    #             elsif a == "가공/제조"
    #                 a_info.a14_godeungeoh = -2
    #             end

    #             # 게
    #             a = r.css(".allergy_wrap//.list_03//dl:nth-child(2)//span").inner_text

    #             if a == "포함"
    #                 a_info.a19_gye = 1
    #             elsif a == "불포함"
    #                 a_info.a19_gye = 0
    #             elsif a == "가공/제조"
    #                 a_info.a19_gye = -2
    #             end

    #             # 돼지고기
    #             a = r.css(".allergy_wrap//.list_03//dl:nth-child(3)//span").inner_text

    #             if a == "포함"
    #                 a_info.a8_piggogi = 1
    #             elsif a == "불포함"
    #                 a_info.a8_piggogi = 0
    #             elsif a == "가공/제조"
    #                 a_info.a8_piggogi = -2
    #             end

    #             #list_04 복숭아, 토마토, 새우
    #             # 복숭아
    #             a = r.css(".allergy_wrap//.list_04//dl:nth-child(1)//span").inner_text

    #             if a == "포함"
    #                 a_info.a6_peach = 1
    #             elsif a == "불포함"
    #                 a_info.a6_peach = 0
    #             elsif a == "가공/제조"
    #                 a_info.a6_peach = -2
    #             end

    #             # 토마토
    #             a = r.css(".allergy_wrap//.list_04//dl:nth-child(2)//span").inner_text

    #             if a == "포함"
    #                 a_info.a7_tomato = 1
    #             elsif a == "불포함"
    #                 a_info.a7_tomato = 0
    #             elsif a == "가공/제조"
    #                 a_info.a7_tomato = -2
    #             end

    #             # 새우
    #             a = r.css(".allergy_wrap//.list_04//dl:nth-child(3)//span").inner_text

    #             if a == "포함"
    #                 a_info.a13_saewoo = 1
    #             elsif a == "불포함"
    #                 a_info.a13_saewoo = 0
    #             elsif a == "가공/제조"
    #                 a_info.a13_saewoo = -2
    #             end

    #             #list_05 아황산류, 호두, 닭고기
    #             # 아황산류
    #             a = r.css(".allergy_wrap//.list_05//dl:nth-child(1)//span").inner_text

    #             if a == "포함"
    #                 a_info.a21_ahwangsan = 1
    #             elsif a == "불포함"
    #                 a_info.a21_ahwangsan = 0
    #             elsif a == "가공/제조"
    #                 a_info.a21_ahwangsan = -2
    #             end

    #             # 호두
    #             a = r.css(".allergy_wrap//.list_05//dl:nth-child(2)//span").inner_text

    #             if a == "포함"
    #                 a_info.a4_hodu = 1
    #             elsif a == "불포함"
    #                 a_info.a4_hodu = 0
    #             elsif a == "가공/제조"
    #                 a_info.a4_hodu = -2
    #             end

    #             # 닭고기
    #             a = r.css(".allergy_wrap//.list_05//dl:nth-child(3)//span").inner_text

    #             if a == "포함"
    #                 a_info.a11_ddakgogi = 1
    #             elsif a == "불포함"
    #                 a_info.a11_ddakgogi = 0
    #             elsif a == "가공/제조"
    #                 a_info.a11_ddakgogi = -2
    #             end

    #             #list_06 쇠고기, 오징어, 조개류
    #             # 쇠고기
    #             a = r.css(".allergy_wrap//.list_06//dl:nth-child(1)//span").inner_text

    #             if a == "포함"
    #                 a_info.a12_shoigogi = 1
    #             elsif a == "불포함"
    #                 a_info.a12_shoigogi = 0
    #             elsif a == "가공/제조"
    #                 a_info.a12_shoigogi = -2
    #             end

    #             # 오징어
    #             a = r.css(".allergy_wrap//.list_06//dl:nth-child(2)//span").inner_text

    #             if a == "포함"
    #                 a_info.a20_ohjingeoh = 1
    #             elsif a == "불포함"
    #                 a_info.a20_ohjingeoh = 0
    #             elsif a == "가공/제조"
    #                 a_info.a20_ohjingeoh = -2
    #             end

    #             # 조개류
    #             a = r.css(".allergy_wrap//.list_06//dl:nth-child(3)//span").inner_text

    #             if a == "포함"
    #                 a_info.a18_jogaeryu = 1
    #             elsif a == "불포함"
    #                 a_info.a18_jogaeryu = 0
    #             elsif a == "가공/제조"
    #                 a_info.a18_jogaeryu = -2
    #             end

    #             #제공하지 않음
    #             a_info.a15_honghap = -1
    #             a_info.a16_junbok  = -1
    #             a_info.a17_gul  = -1
                
    #             a_info.save
    #         end
    #     end
    # end


    # def self.Baskinrobbins
    #     for pageNum in range (1,4)
    #         url = "https://www.baskinrobbins.co.kr/menu/nutrition_new.php?Page="+pageNum+"&ScProd=&ScNutri=&ScAmount="
    #         data = Nokogiri::HTML(open(url))
    #         rows = data.css('.table_allergy tbody tr')

    #         rows.each do |r|
    #             m_name = r.css(':nth-child(1)').text
    #         end
    #     end
    # end

    def self.DunkinDonuts
        r_name = "던킨도너츠"
        url = "https://www.dunkindonuts.co.kr/info/nutrient.php"
        before = Nokogiri::HTML(open(url))
        count = before.css(".result_total//span").text.to_i
        puts "==========던킨==========="
        num = (count.to_f/20).ceil()

        for pageNum in 1..num do
            url = "https://www.dunkindonuts.co.kr/info/nutrient.php?Page="+ "#{pageNum}" +"&searchword=&skey=&sdic="
            data = Nokogiri::HTML(open(url))
            rows = data.css('.table//tbody//tr:not(:nth-of-type(1))')

            rows.each do |r|
                m_name = r.css('td.product').text

                if Menu.where(menu_name: m_name)[0].nil?
                    a_info = Menu.new
                else
                    a_info = Menu.where(restaurant_name: r_name, menu_name: m_name)[0]
                end
    
                a_info.restaurant_name = r_name
                a_info.restaurant_id = Restaurant.where(restaurant_name: r_name)[0].id
                a_info.menu_name = m_name

                #알레르기 정보 배열
                if r.css('td.constituent').text != ""
                    allergies = r.css('td.constituent').text.split(',')
                else
                    allergies = [""]
                end

                 #제공안함.: 고등어, 홍합, 전복, 게, 아황산류
                a_info.a1_maemil = 0
                a_info.a2_mil = 0
                a_info.a3_daedu = 0
                a_info.a4_hodu = 0
                a_info.a5_ddangkong = 0
                a_info.a6_peach = 0
                a_info.a7_tomato = 0
                a_info.a8_piggogi = 0
                a_info.a9_nanryu = 0
                a_info.a10_milk = 0
                a_info.a11_ddakgogi = 0
                a_info.a12_shoigogi = 0
                a_info.a13_saewoo = 0
                a_info.a14_godeungeoh = -1
                a_info.a15_honghap = -1
                a_info.a16_junbok = -1
                a_info.a17_gul = 0
                a_info.a18_jogaeryu = 0
                a_info.a19_gye = -1
                a_info.a20_ohjingeoh = 0
                a_info.a21_ahwangsan = -1

                allergies.each do |allergy|
                    allergy = allergy.strip

                    if a_info.a10_milk != 1 && allergy == '우유'
                        a_info.a10_milk = 1
                    elsif a_info.a3_daedu != 1 && allergy == "대두"
                        a_info.a3_daedu = 1
                    elsif a_info.a1_maemil != 1 && allergy == "메밀"
                        a_info.a1_maemil = 1
                    elsif a_info.a2_mil != 1 && allergy == "밀"
                        a_info.a2_mil = 1
                    elsif a_info.a4_hodu != 1 && allergy == "호두"
                        a_info.a4_hodu = 1
                    elsif a_info.a5_ddangkong != 1 && allergy == "땅콩"
                        a_info.a5_ddangkong = 1
                    elsif a_info.a6_peach != 1 && allergy == "복숭아"
                        a_info.a6_peach = 1
                    elsif a_info.a7_tomato != 1 && allergy == "토마토"
                        a_info.a7_tomato = 1
                    elsif a_info.a8_piggogi != 1 && allergy == "돼지고기"
                        a_info.a8_piggogi = 1
                    elsif a_info.a9_nanryu != 1 && allergy == "계란"
                        a_info.a9_nanryu = 1
                    elsif a_info.a11_ddakgogi != 1 && allergy == "닭고기"
                        a_info.a11_ddakgogi = 1
                    elsif a_info.a12_shoigogi != 1 && allergy == "쇠고기"
                        a_info.a12_shoigogi = 1
                    elsif a_info.a13_saewoo != 1 && allergy == "새우"
                        a_info.a13_saewoo = 1
                    elsif a_info.a14_godeungeoh != 1 && allergy == "고등어"
                        a_info.a14_godeungeoh = 1
                    elsif a_info.a15_honghap != 1 && allergy == "홍합"
                        a_info.a15_honghap = 1
                    elsif a_info.a16_junbok != 1 && allergy == "전복"
                        a_info.a16_junbok = 1
                    elsif a_info.a17_gul != 1 && allergy == "조개류(굴)"
                        a_info.a17_gul = 1
                    elsif a_info.a18_jogaeryu != 1 && allergy == "조개류(굴)"
                        a_info.a18_jogaeryu = 1
                    elsif a_info.a19_gye != 1 && allergy == "게"
                        a_info.a19_gye = 1
                    elsif a_info.a20_ohjingeoh != 1 && allergy == "오징어"
                        a_info.a20_ohjingeoh = 1
                    elsif a_info.a21_ahwangsan != 1 && allergy == "아황산류"
                        a_info.a21_ahwangsan = 1
                    end  
                end

                a_info.save
            end

        end 
    end

    # def self.PizzanaraCG
       
    #     url = "http://pncg.co.kr/nutrition/main.html"
    #     data = Nokogiri::HTML(open(url))
    #     rows = data.css('.table_allergy tbody tr')

    #     rows.each do |r|
    #         m_name = r.css(':nth-child(1)').text
    #     end
    
    # end

    # def self.PizzaEttang
       
    #     url = "https://m.pizzaetang.com/menu/nutrient.html"
    #     data = Nokogiri::HTML(open(url))
    #     rows = data.css('.table_allergy tbody tr')

    #     rows.each do |r|
    #         m_name = r.css(':nth-child(1)').text
    #     end
        
    # end

    # def self.PizzaAlvolo
       
    #     url = "https://m.pizzaalvolo.co.kr/menu/menu_sideView.asp?class_id=40&cate_id=02&base_id=4055"
    #     data = Nokogiri::HTML(open(url))
    #     rows = data.css('.table_allergy tbody tr')

    #     rows.each do |r|
    #         m_name = r.css(':nth-child(1)').text
    #     end
        
    # end

    # def self.CoffeeBean
       
    #     url = "http://www.coffeebeankorea.com/menu/list.asp?category=4"
    #     data = Nokogiri::HTML(open(url))
    #     rows = data.css('.table_allergy tbody tr')

    #     rows.each do |r|
    #         m_name = r.css(':nth-child(1)').text
    #     end
        
    # end

    #담김쌈http://www.damgimssam.com/?page_id=1420
    
    #https://stackoverflow.com/questions/30746397/can-nokogiri-interpret-javascript-web-scraping
    #####################################################################
    # if !Menu.exists?(restaurant_name: "서브웨이") 
    #     self.Subway
    # end

    # if !Menu.exists?(restaurant_name: "맘스터치") 
    #     self.Momstouch
    # end

    #if !Allergy.exists?(restaurant_name: "한솥") 
        #self.Hansot
    #end

    def self.PizzaSchool
        url = "http://pizzaschool.net/menu/"
        before = Nokogiri::HTML(open(url))
        links = before.css('.grid-entry-title//a').map { |link| link['href'] }
        titles = before.css('.grid-entry-title//a').map { |title| title['title']}
        idx = 0
        r_name = "피자스쿨"

        links.each do |l|
            data = Nokogiri::HTML(open(l))
            m_name = titles[idx]
            idx = idx + 1
            
            if Menu.where(menu_name: m_name)[0].nil?
                a_info = Menu.new
            else
                a_info = Menu.where(restaurant_name: r_name, menu_name: m_name)[0]
            end

            a_info.restaurant_name = r_name
            a_info.restaurant_id = Restaurant.where(restaurant_name: r_name)[0].id
            a_info.menu_name = m_name

            
            #제공안함.: 메밀. 호두, 땅콩, 복숭아, 고등어, 홍합, 전복, 조개류, 게, 오징어
            a_info.a1_maemil = -1
            a_info.a2_mil = 0
            a_info.a3_daedu = 0
            a_info.a4_hodu = -1
            a_info.a5_ddangkong = -1
            a_info.a6_peach = -1
            a_info.a7_tomato = 0
            a_info.a8_piggogi = 0
            a_info.a9_nanryu = 0
            a_info.a10_milk = 0
            a_info.a11_ddakgogi = 0
            a_info.a12_shoigogi = 0
            a_info.a13_saewoo = 0
            a_info.a14_godeungeoh = -1
            a_info.a15_honghap = -1
            a_info.a16_junbok = -1
            a_info.a17_gul = 0
            a_info.a18_jogaeryu = -1
            a_info.a19_gye = -1
            a_info.a20_ohjingeoh = -1
            a_info.a21_ahwangsan = 0

            a_trs = data.css('#toggle-id-2-container//div//table//tbody//tr//td').map {|allergy| allergy.text}
            a_trs.slice!(0)

            a_trs.each do |a_tr|
                allergies = a_tr.split('/')
                allergies.each do |allergy| 
                    if a_info.a10_milk != 1 && allergy == '우유'
                        a_info.a10_milk = 1
                    elsif a_info.a3_daedu != 1 && allergy == "대두"
                        a_info.a3_daedu = 1
                    elsif a_info.a1_maemil != 1 && allergy == "메밀"
                        a_info.a1_maemil = 1
                    elsif a_info.a2_mil != 1 && allergy == "밀"
                        a_info.a2_mil = 1
                    elsif a_info.a4_hodu != 1 && allergy == "호두"
                        a_info.a4_hodu = 1
                    elsif a_info.a5_ddangkong != 1 && allergy == "땅콩"
                        a_info.a5_ddangkong = 1
                    elsif a_info.a6_peach != 1 && allergy == "복숭아"
                        a_info.a6_peach = 1
                    elsif a_info.a7_tomato != 1 && allergy == "토마토"
                        a_info.a7_tomato = 1
                    elsif a_info.a8_piggogi != 1 && allergy == "돼지고기"
                        a_info.a8_piggogi = 1
                    elsif a_info.a9_nanryu != 1 && allergy == "계란"
                        a_info.a9_nanryu = 1
                    elsif a_info.a11_ddakgogi != 1 && allergy == "닭고기"
                        a_info.a11_ddakgogi = 1
                    elsif a_info.a12_shoigogi != 1 && allergy == "쇠고기"
                        a_info.a12_shoigogi = 1
                    elsif a_info.a13_saewoo != 1 && allergy == "새우"
                        a_info.a13_saewoo = 1
                    elsif a_info.a14_godeungeoh != 1 && allergy == "고등어"
                        a_info.a14_godeungeoh = 1
                    elsif a_info.a15_honghap != 1 && allergy == "홍합"
                        a_info.a15_honghap = 1
                    elsif a_info.a16_junbok != 1 && allergy == "전복"
                        a_info.a16_junbok = 1
                    elsif a_info.a17_gul != 1 && allergy == "굴"
                        a_info.a17_gul = 1
                    elsif a_info.a18_jogaeryu != 1 && allergy == "조개류"
                        a_info.a18_jogaeryu = 1
                    elsif a_info.a19_gye != 1 && allergy == "게"
                        a_info.a19_gye = 1
                    elsif a_info.a20_ohjingeoh != 1 && allergy == "오징어"
                        a_info.a20_ohjingeoh = 1
                    elsif a_info.a21_ahwangsan != 1 && allergy == "아황산류"
                        a_info.a21_ahwangsan = 1
                    end  
                end 
            end



            a_info.save

        end
    end


end
