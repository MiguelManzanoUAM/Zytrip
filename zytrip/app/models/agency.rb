class Agency < ApplicationRecord
	has_many :trips, dependent: :destroy

	#Busqueda de agencias mediante barra de busqueda
  	def self.search(search)
    	if search
      		where(["name like ?", "%#{search}%"])
    	else
      		all
    	end
  	end

  	#Exporta todos los datos en un csv
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |agency|
  				csv << agency.attributes.values_at(*fields)
  			end
  		end
  	end

  	#Importa los datos desde un csv
  	def self.import
  		path = Rails.root + "app/csv/agencies.csv"
  		CSV.foreach(path, headers: true) do |row|
  			agency_hash = row.to_hash
			if Agency.where("id" => agency_hash['id']).exists?
  				agency = Agency.find_by(id: agency_hash['id'])
  			else
  				agency = Agency.create!(agency_hash)
  			end
  			agency.update(agency_hash)
  		end
  	end
end
