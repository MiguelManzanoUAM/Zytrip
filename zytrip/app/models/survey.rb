class Survey < ApplicationRecord
	belongs_to :user

	#####################################################
  	# Exporta todos los datos en un csv
  	#####################################################
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |survey|
  				csv << survey.attributes.values_at(*fields)
  			end
  		end
  	end

  	#####################################################
  	# Importa los datos desde un csv
  	#####################################################
  	def self.import
  		path = Rails.root + "app/csv/surveys.csv"
  		CSV.foreach(path, headers: true) do |row|
  			survey_hash = row.to_hash
  			if Survey.where("id" => survey_hash['id']).exists?
  				survey = Survey.find_by(id: survey_hash['id'])
  			else
  				user = User.find_by(id: survey_hash['user_id'])

				survey = Survey.create!(survey_hash)
  			end
  			survey.update(survey_hash)
  		end
  		
  	end
end
