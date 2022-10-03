class Preference < ApplicationRecord

	##############################
	# Preferences Relations
	##############################
	has_one :service, dependent: :destroy
	has_one :company, dependent: :destroy
	has_one :topic, dependent: :destroy
	belongs_to :trip

	##############################
	#Preferences enums
	##############################

	enum destination: {
		spain: 0,
		europe: 1,
		africa: 2,
		america: 3,
		asia: 4
	}, _prefix: true

	enum budget: {
		low: 0,
		medium: 1,
		high: 2,
		expensive: 3
	}, _prefix: true

	enum duration: {
		short: 0,
		ordinary: 1,
		long: 2,
		overlong: 3
	}, _prefix: true

	################################################################
	# Helper functions for enums
	# --------------------------
	# -> By using _prefix: true you can access to helpers like this:
	#
	#    preference.destination_spain?  ----> destination == 'spain'
	# 
	# -> This helpers will be used in the survey controller
	################################################################
	

	#######################################
	# Helper functions for associations
	#######################################

	# ----- Services ----- #

	def remarkable_gastronomy?
		return true if self.service.gastronomy == true
		return false
	end

	def remarkable_lodging?
		return true if self.service.lodging == true
		return false
	end

	def remarkable_activities?
		return true if self.service.activities == true
		return false
	end

	# ----- Companies ----- #

	def family_as_company?
		return true if self.company.family == true
		return false
	end

	def partner_as_company?
		return true if self.company.romantic == true
		return false
	end

	def friends_as_company?
		return true if self.company.friends == true
		return false
	end

	def alone_as_company?
		return true if self.company.alone == true
		return false
	end

	def new_people_as_company?
		return true if self.company.people == true
		return false
	end

	# ----- Topic ----- #

	def beach_as_main_topic?
		return true if self.topic.beach == true
		return false
	end

	def nature_as_main_topic?
		return true if self.topic.nature == true
		return false
	end

	def tourism_as_main_topic?
		return true if self.topic.tourism == true
		return false
	end

	def relax_as_main_topic?
		return true if self.topic.relax == true
		return false
	end

	#Exporta todos los datos en un csv
  	def self.to_csv(fields = column_names, options = {})
  		CSV.generate(options) do |csv|
  			csv << fields
  			all.each do |preference|
  				csv << preference.attributes.values_at(*fields)
  			end
  		end
  	end

  	#Importa los datos desde un csv
  	def self.import
  		path = Rails.root + "app/csv/preferences.csv"
  		CSV.foreach(path, headers: true) do |row|
  			preference_hash = row.to_hash
			if Preference.where("id" => preference_hash['id']).exists?
  				preference = Preference.find_by(id: preference_hash['id'])
  			else
  				preference = Preference.create!(preference_hash)
  			end
  			preference.update(preference_hash)
  		end
  	end
end
