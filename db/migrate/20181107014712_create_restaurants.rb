class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      #레스토랑 이름
      t.string :restaurant_name
   
      #식당 전체 알레르기 정보
      t.integer :a1_maemil
      t.integer :a2_mil
      t.integer :a3_daedu
      t.integer :a4_hodu
      t.integer :a5_ddangkong
      t.integer :a6_peach
      t.integer :a7_tomato
      t.integer :a8_piggogi
      t.integer :a9_nanryu
      t.integer :a10_milk
      t.integer :a11_ddakgogi
      t.integer :a12_shoigogi
      t.integer :a13_saewoo
      t.integer :a14_godeungeoh
      t.integer :a15_honghap
      t.integer :a16_junbok
      t.integer :a17_gul
      t.integer :a18_jogaeryu
      t.integer :a19_gye
      t.integer :a20_ohjingeoh
      t.integer :a21_ahwangsan

      t.string :image
      t.timestamps
    end
  end
end
