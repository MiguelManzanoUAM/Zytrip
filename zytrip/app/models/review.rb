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
  	# Añadir review a un viaje y usuario
  	#####################################################
  	def self.add_review(user_id, trip_id, rat, com)
  		user = User.find_by(id: user_id)
  		trip = Trip.find_by(id: trip_id)

		if !(user.trips.include? trip)
			review = Review.create!(user_id: user.id, trip_id: trip.id, rating: rat, comment: com)
			user.trips << trip
			user.save
		end
	end

	#####################################################
  	# Añade el viaje a la lista de viajes del usuario
  	# si no estaba aún
  	#####################################################
  	def self.add_user_to_trip(review)
  		user = User.find_by(id: review.user_id)
  		trip = Trip.find_by(id: review.trip_id)

  		if !(user.trips.include? trip)
			user.trips << trip
			user.save
		end
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

  	#####################################################
  	# Obtiene la valoración que un usuario ha dado
  	# a un viaje en específico
  	#####################################################
  	def self.get_review(user, trip)
  		review = Review.find_by(user_id: user.id, trip_id: trip.id)
  		return review.rating
  	end
end
