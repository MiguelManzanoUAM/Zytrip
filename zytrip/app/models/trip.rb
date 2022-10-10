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

  	#####################################################
  	# Obtiene las preferencias de un viaje
  	#####################################################
  	def self.trip_preferences(trip)
  		preferences = []

  		if trip.preference
  			#1) destination
  			if trip.preference.destination_asia?
  				preferences << "Asia"
  			elsif trip.preference.destination_spain?
  				preferences << "Rutas Ibéricas"
  			elsif trip.preference.destination_africa?
  				preferences << "África"
  			elsif trip.preference.destination_america?
  				preferences << "América"
  			else
  				preferences << "Europa"
  			end

  			#2) budget
  			if trip.preference.budget_low?
  				preferences << "Menos de 500€"
  			elsif trip.preference.budget_medium?
  				preferences << "Entre 500 y 1000€"
  			elsif trip.preference.budget_high?
  				preferences << "Entre 1000 y 1500€"
  			else
  				preferences << "Más de 1500€"
  			end

  			#3) duration
  			if trip.preference.duration_short?
  				preferences << "Menos de 3 días"
  			elsif trip.preference.duration_ordinary?
  				preferences << "Entre 3 y 5 días"
  			elsif trip.preference.duration_long?
  				preferences << "Entre 5 y 7 días"
  			else
  				preferences << "Más de una semana"
  			end

  			#4) servicios
  			if trip.preference.remarkable_lodging?
  				preferences << "Alojamiento"
  			end

  			if trip.preference.remarkable_activities?
  				preferences << "Actividades"
  			end

  			if trip.preference.remarkable_gastronomy?
  				preferences << "Gastronomía"
  			end

  			#5) Compañía
  			if trip.preference.family_as_company?
  				preferences << "Viaje con familia"
  			end

  			if trip.preference.friends_as_company?
  				preferences << "Viaje con amigos"
  			end

  			if trip.preference.alone_as_company?
  				preferences << "Viajar solo"
  			end

  			if trip.preference.new_people_as_company?
  				preferences << "Conocer gente"
  			end

  			if trip.preference.partner_as_company?
  				preferences << "Escapada romántica"
  			end

  			#6) Temática

  			if trip.preference.beach_as_main_topic?
  				preferences << "Playa"
  			end

  			if trip.preference.nature_as_main_topic?
  				preferences << "Naturaleza"
  			end

  			if trip.preference.tourism_as_main_topic?
  				preferences << "Turismo"
  			end

  			if trip.preference.relax_as_main_topic?
  				preferences << "Descansar"
  			end
  		end

  		return preferences
  	end

  	#####################################################
  	# Comprueba si el viaje tiene cierta preferencia
  	# ---------------------------------------------------
  	# La preferencia será un string con el valor de la
  	# preferencia así como hemos configurado en el
  	# método anterior
  	#####################################################
  	def self.trip_has_preference(trip, preference)

  		#1) destination
  		if preference == "Asia" && trip.preference.destination_asia?
  			return true
  		end
  		if preference == "América" && trip.preference.destination_america?
  			return true
  		end
  		if preference == "Rutas Ibéricas" && trip.preference.destination_spain?
  			return true
  		end
  		if preference == "África" && trip.preference.destination_africa?
  			return true
  		end
  		if preference == "Europa" && trip.preference.destination_europe?
  			return true
  		end

  		#2) budget
  		if preference == "Menos de 500€" && trip.preference.budget_low?
  			return true
  		end
  		if preference == "Entre 500 y 1000€" && trip.preference.budget_medium?
  			return true
  		end
  		if preference == "Entre 1000 y 1500€" && trip.preference.budget_high?
  			return true
  		end
  		if preference == "Más de 1500€" && trip.preference.budget_expensive?
  			return true
  		end

  		#3) duration
  		if preference == "Menos de 3 días" && trip.preference.duration_short?
  			return true
  		end
  		if preference == "Entre 3 y 5 días" && trip.preference.duration_ordinary?
  			return true
  		end
  		if preference == "Entre 5 y 7 días" && trip.preference.duration_long?
  			return true
  		end
  		if preference == "Más de una semana" && trip.preference.duration_overlong?
  			return true
  		end

  		#4) Services
  		if preference == "Alojamiento" && trip.preference.remarkable_lodging?
  			return true
  		end
  		if preference == "Actividades" && trip.preference.remarkable_activities?
  			return true
  		end
  		if preference == "Gastronomía" && trip.preference.remarkable_gastronomy?
  			return true
  		end

  		#5) Company
  		if preference == "Viaje con familia" && trip.preference.family_as_company?
  			return true
  		end
  		if preference == "Viaje con amigos" && trip.preference.friends_as_company?
  			return true
  		end
  		if preference == "Viajar solo" && trip.preference.alone_as_company?
  			return true
  		end
  		if preference == "Conocer gente" && trip.preference.new_people_as_company?
  			return true
  		end
  		if preference == "Escapada romántica" && trip.preference.partner_as_company?
  			return true
  		end

  		#6) Topic
  		if preference == "Playa" && trip.preference.beach_as_main_topic?
  			return true
  		end
  		if preference == "Naturaleza" && trip.preference.nature_as_main_topic?
  			return true
  		end
  		if preference == "Turismo" && trip.preference.tourism_as_main_topic?
  			return true
  		end
  		if preference == "Descansar" && trip.preference.relax_as_main_topic?
  			return true
  		end

  		#No ha encontrado la preferencia
  		return false
  	end

end
