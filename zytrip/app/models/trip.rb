class Trip < ApplicationRecord
	belongs_to :organizer, class_name: "User"
	has_and_belongs_to_many :users
	has_many :reviews, dependent: :destroy
	has_one :preference, dependent: :destroy

	#####################################################
	#Busqueda de viajes mediante barra de busqueda
	#####################################################
  	def self.search(search)
    	if search
      		where(["title like ?", "%#{search}%"])
    	else
      		all
    	end
  	end

  	#####################################################
  	#Exporta todos los datos en un csv
  	#####################################################
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |trip|
  				csv << trip.attributes.values_at(*fields)
  			end
  		end
  	end

  	#####################################################
  	#Importa los datos desde un csv
  	#####################################################
  	def self.import
  		path = Rails.root + "app/csv/trips.csv"
  		CSV.foreach(path, headers: true) do |row|
  			trip_hash = row.to_hash
  			if Trip.where("id" => trip_hash['id']).exists?
  				trip = Trip.find_by(id: trip_hash['id'])
  			else
  				trip = Trip.create!(trip_hash)
  			end
  			trip.update(trip_hash)
  		end
  	end

  	#####################################################
  	# Obtiene la valoración media de los viajes
  	#####################################################
  	def self.trips_ratings
  		trips = Trip.all
  		reviews = Review.all

  		trips.each do |trip|
  			rating = 0
  			n_trips = 0
  			reviews.each do |review|
  				if review.trip_id == trip.id
  					rating = rating + review.rating
  					n_trips = n_trips + 1
  				end
  			end

  			if n_trips > 0
  				trip.rating = rating/n_trips
  				trip.save
  			end
  		end
  	end

end
