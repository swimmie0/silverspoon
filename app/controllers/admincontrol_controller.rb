class AdmincontrolController < ApplicationController
    before_action :authorize_admin

    def index
    end
    
    def zizuminfo
        @zizuminfos = Zizuminfo.all
    end

    def restaurant
        @restaurants = Restaurant.all
    end

    def zizumupdate
        puts "=============="
        puts params[:zizum]
        if params[:zizum] == "zizumall"
            # Zizuminfo.Subway        #1
            # Zizuminfo.Momstouch     #2
            # # Zizuminfo.Raracost
            # Zizuminfo.Vips          #3
            Zizuminfo.Coffeebean    #4
            Zizuminfo.Popeyes       #5
            # Zizuminfo.Baskin        #6
            # Zizuminfo.PizzaSchool   #7
            Zizuminfo.SeasonsTable  #8
            # Zizuminfo.Burgerking    #9
            # Zizuminfo.DunkinDonuts  #10   
        end

        redirect_to admincontrol_zizuminfo_path
    end

    def resupdate
        res = params[:res]
        puts params[:res]
        if res == "resall"
            Restaurant.RestaurantName
        elsif res == "서브웨이"
            Zizuminfo.Subway
        elsif res =="맘스터치"
            Zizuminfo.Momstouch
        elsif res == "라라코스트"
            Zizuminfo.Raracost
        elsif res == "빕스"
            Zizuminfo.Vips
        elsif res == "커피빈"
            Zizuminfo.Coffeebean
        elsif res == "파파이스"
            Zizuminfo.Popoyes
        elsif res == "배스킨라빈스"
            Zizuminfo.Baskin
        elsif res == "피자스쿨"
            Zizuminfo.PizzaSchool
        elsif res == "계절밥상"
            Zizuminfo.SeasonsTable
        elsif res == "버거킹"
            Zizuminfo.Burgerking
        elsif res == "던킨도너츠"
            Zizuminfo.DunkinDonuts
        end


        redirect_to admincontrol_restaurant_path
    end


    def menu
        @restaurants = Restaurant.all
    end

    def menuupdate
        res = params[:res]
        puts params[:res]
        if res == "resall"
            Menu.Subway        #1
            Menu.Momstouch     #2
            # Menu.Raracost
            Menu.Vips          #3
            Menu.Coffeebean    #4
            Menu.Popeyes       #5
            Menu.Baskin        #6
            Menu.PizzaSchool   #7
            Menu.SeasonsTable  #8
            Menu.Burgerking    #9
            Menu.DunkinDonuts  #10   
        elsif res == "서브웨이"
            Menu.Subway
        elsif res =="맘스터치"
            Menu.Momstouch
        elsif res == "라라코스트"
            Menu.Raracost
        elsif res == "빕스"
            Menu.Vips
        elsif res == "커피빈"
            Menu.Coffeebean
        elsif res == "파파이스"
            Menu.Popoyes
        elsif res == "배스킨라빈스"
            Menu.Baskin
        elsif res == "피자스쿨"
            Menu.PizzaSchool
        elsif res == "계절밥상"
            Menu.SeasonsTable
        elsif res == "버거킹"
            Menu.Burgerking
        elsif res == "던킨도너츠"
            Menu.DunkinDonuts
        end


        redirect_to admincontrol_menu_path
    end

end
