class AdditionalInformation < ApplicationRecord
	belongs_to :user

	validate :validate_additional_info

	#####################################################
	# Validaciones
	#####################################################
	def validate_additional_info

		if instagram_nickname.length > 10
		  errors.add :instagram_nickname, 'introduce un más usuario más corto (máximo 10 caracteres)'
		end

		if !(phone_number =~ /^\+(?:[0-9]●?){6,14}[0-9]$/)
		  errors.add :phone_number, 'Introduzca un nº teléfono válido'
		end

		if slogan.length > 30
		  errors.add :slogan, 'slogan demasiado largo (máximo 30 caracteres)'
		end

		if description.length > 250
		  errors.add :description, 'descripción demasiado extensa (máximo 250 caracteres)'
		end
	end

	def self.valid_phone_number(number)
		if !(number =~ /^\+(?:[0-9]●?){6,14}[0-9]$/)
		  return false
		end

		return true
	end

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
