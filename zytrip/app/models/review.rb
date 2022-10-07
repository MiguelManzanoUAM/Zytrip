class Review < ApplicationRecord
	belongs_to :user
	belongs_to :trip

	#####################################################
  	# Exporta todos los datos en un csv
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
  	# Importa los datos desde un csv
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

  	#####################################################
  	# Obtiene las valoraciones de un viaje
  	#####################################################
  	def self.trip_reviews(trip)
  		reviews = []
  		Review.all.each do |review|
  			if review.trip_id == trip.id
  				reviews << review
  			end
  		end

  		return reviews
  	end

  	#####################################################
  	# Obtiene el usuario de la review
  	#####################################################
  	def self.get_user(review)
  		user = User.find_by(id: review.user_id)
  		return user
  	end

  	#####################################################
  	# Obtiene el viaje perteneciente a la review
  	#####################################################
  	def self.get_trip(review)
  		trip = Trip.find_by(id: review.trip_id)
  		return trip
  	end
end
