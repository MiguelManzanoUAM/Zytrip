class Service < ApplicationRecord
	belongs_to :preference

	#Exporta todos los datos en un csv
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |service|
  				csv << service.attributes.values_at(*fields)
  			end
  		end
  	end

  	#Importa los datos desde un csv
  	def self.import
  		path = Rails.root + "app/csv/services.csv"
  		CSV.foreach(path, headers: true) do |row|
  			service_hash = row.to_hash
			if Service.where("id" => service_hash['id']).exists?
  				service = Service.find_by(id: service_hash['id'])
  			else
  				service = Service.create!(service_hash)
  			end
  			service.update(service_hash)
  		end
  	end
end
