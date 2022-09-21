class Topic < ApplicationRecord
	belongs_to :preference

	#Exporta todos los datos en un csv
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |topic|
  				csv << topic.attributes.values_at(*fields)
  			end
  		end
  	end

  	#Importa los datos desde un csv
  	def self.import
  		path = Rails.root + "app/csv/topics.csv"
  		CSV.foreach(path, headers: true) do |row|
  			topic_hash = row.to_hash
			if Topic.where("id" => topic_hash['id']).exists?
  				topic = Topic.find_by(id: topic_hash['id'])
  			else
  				topic = Topic.create!(topic_hash)
  			end
  			topic.update(topic_hash)
  		end
  	end
end
