class Review < ApplicationRecord
	belongs_to :user
	belongs_to :trip

	#####################################################
  	#Exporta todos los datos en un csv
  	#####################################################
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |review|
  				csv << review.attributes.values_at(*fields)
  			end
  		end
  	end

  	#####################################################
  	#Importa los datos desde un csv
  	#####################################################
  	def self.import
  		path = Rails.root + "app/csv/reviews.csv"
  		CSV.foreach(path, headers: true) do |row|
  			review_hash = row.to_hash
  			if Review.where("id" => review_hash['id']).exists?
  				review = Review.find_by(id: review_hash['id'])
  			else
  				user = User.find_by(id: review_hash['user_id'])
  				trip = Trip.find_by(id: review_hash['trip_id'])

  				if !(user.trips.include? trip)
					review = Review.create!(review_hash)
					user.trips << trip
					user.save
				end
  			end
  			review.update(review_hash)
  		end
  		
  		#Actualizamos la valoracion media de los viajes
  		Trip.trips_ratings()
  	end
end
