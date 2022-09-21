class Company < ApplicationRecord
	belongs_to :preference

	#Exporta todos los datos en un csv
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |company|
  				csv << company.attributes.values_at(*fields)
  			end
  		end
  	end

  	#Importa los datos desde un csv
  	def self.import
  		path = Rails.root + "app/csv/companies.csv"
  		CSV.foreach(path, headers: true) do |row|
  			company_hash = row.to_hash
			if Company.where("id" => company_hash['id']).exists?
  				company = Company.find_by(id: company_hash['id'])
  			else
  				company = Company.create!(company_hash)
  			end
  			company.update(company_hash)
  		end
  	end
end
