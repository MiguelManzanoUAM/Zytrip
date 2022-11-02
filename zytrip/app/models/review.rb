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
  	# a un viaje en específico. Al haber podido dar más
  	# de una valoracion a un mismo viaje, nos interesa
  	# la última que ha hecho.
  	#####################################################
  	def self.get_review(user, trip)
  		reviews = Review.where(user_id: user.id, trip_id: trip.id)

  		if reviews.size == 1
  			return reviews.first.rating
  		else
  			return reviews.order('created_at DESC').first.rating
  		end
  	end

  	#####################################################
  	# Obtiene la última Review que un usuario haya hecho
  	# en un viaje 
  	#####################################################
  	def self.get_best_user_trip_review(user, trip_id)
  		reviews = Review.where(user_id: user.id, trip_id: trip_id)

  		if reviews.size == 1
  			return reviews.first
  		else
  			return reviews.order('created_at DESC').first
  		end
  	end

  	#####################################################
  	# Obtiene las valoraciones de un usuario en concreto
  	#####################################################
  	def self.get_user_reviews(user)
  		user_reviews = Review.where(user_id: user.id)
  		reviews = []
  		trips_ids = []

  		if user_reviews.size != 0
	  		user_reviews.each do |review|
	  			if !(trips_ids.include? review.trip_id)
	  				trips_ids << review.trip_id
	  			end
	  		end

	  		trips_ids.each do |trip|
  				reviews << self.get_best_user_trip_review(user, trip)
  			end
  		end

  		return reviews
  	end

  	#####################################################
  	# Obtiene las valoraciones de los usuarios que han 
  	# hecho una valoracion en alguno de los viajes del 
  	# usuario
  	#####################################################
  	def self.get_users_sharing_trips(user)
  		user_reviews = Review.get_user_reviews(user)
  		trips_ids = []
  		users_sharing_trip = []
  		other_user_reviews = []

  		if user_reviews.size != 0
	  		user_reviews.each do |review|
	  			if !(trips_ids.include? review.trip_id)
	  				trips_ids << review.trip_id
	  			end
	  		end

	  		trips_ids.each do |trip_id|
	  			trip = Trip.find_by(id: trip_id)
	  			trip_reviews = Review.trip_reviews(trip)

	  			trip_reviews.each do |review|
	  				if (review.user_id != user.id)
	  					other = User.find_by(id: review.user_id)
	  					other_user_reviews << Review.get_best_user_trip_review(other, trip_id)
	  				end
	  			end
	  		end
	  	end

  		return other_user_reviews
  	end

  	#####################################################
  	# Obtiene las reviews de los usuarios que han hecho 
  	# una valoracion parecida en alguno de los viajes 
  	# del usuario.
  	# Consideraremos valoraciones parecidas aquellas que
  	# se encuentren en un intervalo < 0.5 de diferencia
  	#####################################################
  	def self.get_similar_reviews(user)
  		user_reviews = Review.get_user_reviews(user)
  		other_reviews = Review.get_users_sharing_trips(user)
  		similar_reviews = []

  		if ((user_reviews.size != 0) && (other_reviews.size != 0))
	  		user_reviews.each do |user_review|
	  			other_reviews.each do |other_review|
	  				if (user_review.trip_id == other_review.trip_id)
	  					if ((user_review.rating - other_review.rating).abs() <= 0.5)
	  						similar_reviews << other_review
	  					end
	  				end
	  			end
	  		end
	  	end

  		return similar_reviews
  	end

  	#####################################################
  	# Obtiene los usuarios que han hecho una valoracion
  	# parecida en alguno de los viajes del usuario
  	#####################################################
  	def self.get_similar_reviews_users(user)
  		similar_reviews = Review.get_similar_reviews(user)
  		similar_reviews_users = []

  		if similar_reviews.size != 0
	  		similar_reviews.each do |review|
	  			user_of_review = User.find_by(id: review.user_id)
	  			if !(similar_reviews_users.include? user_of_review)
	  				similar_reviews_users << user_of_review
	  			end
	  		end
	  	end

  		return similar_reviews_users
  	end

  	#####################################################
  	# Obtiene las valoraciones que los usuarios parecidos
  	# han realizado en viajes en los que también hemos
  	# valorado
  	#####################################################
  	def self.get_similar_users_reviews_sharing_trip(user)
  		similar_users = Review.get_similar_reviews_users(user)
  		user_reviews = Review.get_user_reviews(user)
  		user_reviews_trips_ids = []
  		other_reviews = []

  		if user_reviews.size != 0
	  		user_reviews.each do |review|
	  			if !(user_reviews_trips_ids.include? review.trip_id)
	  				user_reviews_trips_ids << review.trip_id
	  			end
	  		end

	  		user_reviews_trips_ids.each do |trip_id|
	  			similar_users.each do |other|
	  				review = Review.find_by(trip_id: trip_id, user_id: other.id)
	  				if review
	  					if !(other_reviews.include? review)
	  						other_reviews << review
	  					end
	  				end
	  			end
	  		end
	  	end

	  	return other_reviews
	end

  	#####################################################
  	# Obtiene la diferencia de valoraciones entre los
  	# usuarios con los que hayamos compartido viajes
  	#####################################################
  	def self.get_similar_users_by_reviews(user)
  		similar_users_ratings = {}
  		similar_users = Review.get_similar_reviews_users(user)

  		if similar_users.size == 0
  			return similar_users_ratings
  		end

  		similar_users.each do |similar_user|
  			similar_users_ratings[similar_user] = 0
  		end

  		user_reviews = Review.get_user_reviews(user)
  		other_reviews = Review.get_similar_users_reviews_sharing_trip(user)

  		if ((user_reviews.size != 0) && (other_reviews.size != 0))
	  		user_reviews.each do |user_review|
	  			other_reviews.each do |other_review|
	  				if (user_review.trip_id == other_review.trip_id)
	  					similar_users_ratings[User.find_by(id: other_review.user_id)] += (user_review.rating - other_review.rating).abs()
	  				end
	  			end
	  		end

	  		similar_users_ratings.keys.each do |key|
	      		similar_users_ratings[key] = (similar_users_ratings[key].to_f).round(3)
	    	end
	    end

  		return similar_users_ratings
  	end

  	#####################################################
  	# Obtiene los 3 usuarios cuya diferencia de
  	# valoraciones sea la más parecida (menor) respecto
  	# a nuestro usuario.
  	# A su vez comprobaremos si los usuarios pertenecen ya
  	# a la lista de amigos de nuestro usuario para evitar
  	# recomendarselo al ser ya amigos
  	#####################################################
  	def self.get_most_similar_users_by_reviews(user)
  		similar_users_with_difference = Review.get_similar_users_by_reviews(user)
  		similar_users = []
  		max_friends = 0
  		most_similar_users = []

  		if similar_users_with_difference.keys.size == 0
  			return most_similar_users
  		end
  		
  		similar_users_sorted = similar_users_with_difference.sort {|a1,a2| a2[1]<=>a1[1]}.reverse.to_h
    	similar_users = similar_users_sorted.keys

    	similar_users.each do |other|
			if !(user.friends.include? other)
				most_similar_users << other
			end
		end

    	return most_similar_users

    end

end
