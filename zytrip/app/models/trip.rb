class Trip < ApplicationRecord
	belongs_to :organizer, class_name: "User"
	has_and_belongs_to_many :users
	has_many :reviews, dependent: :destroy
	has_one :preference, dependent: :destroy

	#Busqueda de viajes mediante barra de busqueda
  	def self.search(search)
    	if search
      		where(["title like ?", "%#{search}%"])
    	else
      		all
    	end
  	end

  	#Exporta todos los datos en un csv
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |trip|
  				csv << trip.attributes.values_at(*fields)
  			end
  		end
  	end

  	#Importa los datos desde un csv
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
end
