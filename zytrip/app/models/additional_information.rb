class AdditionalInformation < ApplicationRecord
	belongs_to :user

	#Exporta todos los datos en un csv
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |additional_information|
  				csv << additional_information.attributes.values_at(*fields)
  			end
  		end
  	end

  	#Importa los datos desde un csv
  	def self.import
  		path = Rails.root + "app/csv/additional_informations.csv"
  		CSV.foreach(path, headers: true) do |row|
  			additional_information_hash = row.to_hash
			if AdditionalInformation.where("id" => additional_information_hash['id']).exists?
  				additional_information = AdditionalInformation.find_by(id: additional_information_hash['id'])
  			else
  				additional_information = AdditionalInformation.create!(additional_information_hash)
  			end
  			additional_information.update(additional_information_hash)
  		end
  	end
end
