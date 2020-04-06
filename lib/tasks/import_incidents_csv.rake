require 'csv'
namespace :import_zizuminfos_csv do
  task :create_zizuminfos => :environment do
    CSV.foreach("public/Zizum.csv", :headers => true).map do |row|
      Zizuminfo.create(
        :id => row[0].to_i,
        :zizum_name => row[1],
        :sido => row[2],
        :sigungu => row[3],
        :sangse_juso => row[4],
        :phone_number	=> row[5],
        :image	=> row[6],
        :restaurant_id	=> row[7].to_i,
        :restaurant_name	=> row[8],
        :created_at	=> row[9],
        :updated_at	=> row[10],
        :explain => row[11]
      )
    end
  end  
end

# require 'csv'
# namespace :import_zizuminfos_csv do
#   task :create_zizuminfos => :environment do
#     CSV.foreach("public/Zizuminfos.csv", :headers => true) do |row|
#       Zizuminfo.create!(row.to_hash)
#     end
#   end  
# end

# namespace :import_restaurants_csv do
#     task :create_restaurants => :environment do
#       CSV.foreach("public/restaurants.csv", :headers => true) do |row|
#         Restaurant.create!(row.to_hash)
#       end
#     end  
#   end

  # namespace :import_posts_csv do
  #   task :create_posts => :environment do
  #     CSV.foreach("public/Post.csv", :headers => true) do |row|
  #       Post.create!(row.to_hash)
  #     end
  #   end  
  # end