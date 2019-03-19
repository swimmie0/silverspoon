class CreateZizuminfos < ActiveRecord::Migration[5.2]
  def change
    create_table :zizuminfos do |t|
        #레스토랑 지점 이름(서브웨이 용산아이파크몰점...)
        t.string :zizum_name
      
        #도로명 주소 기준 시도 시군구 도로명주소 건물번호1-건물번호2
        t.string :sido
        t.string :sigungu
        t.string :sangse_juso
        
  
        t.string :phone_number
        t.string :image
  
        t.belongs_to :restaurant
        t.string :restaurant_name
      t.timestamps
    end
  end
end
