require 'csv'
namespace :import_zizuminfos_csv do
  task :create_zizuminfos => :environment do
    # CSV.foreach("public/Zizuminfo_all.csv", :headers => true) do |row|
    #   Zizuminfo.create!(row.to_hash)
    # end
    csv_text = File.read("public/Zizuminfoss.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Zizuminfo.create!(row.to_hash)  
    end
  end  
end

namespace :import_restaurants_csv do
    task :create_restaurants => :environment do
      CSV.foreach("public/Restaurantss.csv") do |row|
        Restaurant.create(row.to_h)
      end
    end    
end

  # namespace :import_posts_csv do
  #   task :create_posts => :environment do
  #     CSV.foreach("public/Post.csv", :headers => true) do |row|
  #       Post.create!(row.to_hash)
  #     end
  #   end  
  # end