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


  	#####################################################
  	# Obtiene la valoración que un usuario ha dado
  	# en la encuesta. Al poder haber realizado más de una
  	# se tendrá en cuenta la última realizada
  	#####################################################
  	def self.get_user_survey(user)
  		surveys = Survey.where(user_id: user.id)


  		if surveys.size == 1
  			return surveys.first
  		else
  			return surveys.order('created_at DESC').first
  		end
  	end


  	#####################################################
  	# Calcula el porcentaje de satisfacción por parte de
  	# los usuarios con los resultados
  	#####################################################
  	def self.get_results_rating_percentage
  		user_surveys = []
  		user_results_rating = 0
  		percentage = 0.0

  		User.all.each do |user|
  			survey = Survey.get_user_survey(user)

  			if survey
  				user_surveys << survey
  			end
  		end

  		if user_surveys.size !=0
	  		user_surveys.each do |survey|
	  			user_results_rating += (survey.results_rating * 2)
	  		end

	  		percentage = (user_results_rating.to_f / user_surveys.size.to_f)*10

	  		return percentage.round(2)
	  	end

	  	return percentage
	end

	#####################################################
  	# Calcula el porcentaje de satisfacción por parte de
  	# los usuarios con las busquedas interactivas
  	#####################################################
  	def self.get_searches_rating_percentage
  		user_surveys = []
  		user_searches_rating = 0
  		percentage = 0.0

  		User.all.each do |user|
  			survey = Survey.get_user_survey(user)

  			if survey
  				user_surveys << survey
  			end
  		end

  		if user_surveys.size !=0
	  		user_surveys.each do |survey|
	  			user_searches_rating += (survey.preferences_poll_rating * 2)
	  		end

	  		percentage = (user_searches_rating.to_f / user_surveys.size.to_f)*10

	  		return percentage.round(2)
	  	end

	  	return percentage
	end

	#####################################################
  	# Calcula el porcentaje de satisfacción por parte de
  	# los usuarios con Zytrip
  	#####################################################
  	def self.get_zytrip_rating_percentage
  		user_surveys = []
  		user_zytrip_rating = 0
  		percentage = 0.0

  		User.all.each do |user|
  			survey = Survey.get_user_survey(user)

  			if survey
  				user_surveys << survey
  			end
  		end

  		if user_surveys.size !=0
	  		user_surveys.each do |survey|
	  			user_zytrip_rating += (survey.zytrip_rating * 2)
	  		end

	  		percentage = (user_zytrip_rating.to_f / user_surveys.size.to_f)*10

	  		return percentage.round(2)
	  	end

	  	return percentage
	end

	#####################################################
  	# Obtiene los usuarios que han realizado más de una
  	# encuesta de valoración
  	#####################################################
  	def self.get_users_with_various_surveys
  		users_with_various_surveys = []

  		User.all.each do |user|
  			user_surveys = Survey.where(user_id: user.id)

  			if user_surveys.size > 1
  				users_with_various_surveys << user
  			end
  		end

  		return users_with_various_surveys
  	end

  	#####################################################
  	# Calcula el porcentaje de mejora respecto a la 
  	# satisfacción con los resultados de los usuarios
  	#####################################################
  	def self.get_users_results_rating_difference
  		difference = 0.0
  		users_with_various_surveys = Survey.get_users_with_various_surveys

  		users_with_various_surveys.each do |user|
  			user_surveys = Survey.where(user_id: user.id)
  			last_user_survey = user_surveys.order('created_at DESC').first
  			previous_user_survey = user_surveys.order('created_at DESC')[1]
  			difference += last_user_survey.results_rating - previous_user_survey.results_rating
  		end

  		return difference
	end

	#####################################################
  	# Calcula el porcentaje de mejora respecto a la 
  	# valoración de las búsquedas de los usuarios
  	#####################################################
  	def self.get_users_searches_rating_difference
  		difference = 0.0
  		users_with_various_surveys = Survey.get_users_with_various_surveys

  		users_with_various_surveys.each do |user|
  			user_surveys = Survey.where(user_id: user.id)
  			last_user_survey = user_surveys.order('created_at DESC').first
  			previous_user_survey = user_surveys.order('created_at DESC')[1]
  			difference += last_user_survey.preferences_poll_rating - previous_user_survey.preferences_poll_rating
  		end

  		return difference
	end

	#####################################################
  	# Calcula el porcentaje de mejora respecto a la 
  	# valoración de zytrip de los usuarios
  	#####################################################
  	def self.get_users_zytrip_rating_difference
  		difference = 0.0
  		users_with_various_surveys = Survey.get_users_with_various_surveys

  		users_with_various_surveys.each do |user|
  			user_surveys = Survey.where(user_id: user.id)
  			last_user_survey = user_surveys.order('created_at DESC').first
  			previous_user_survey = user_surveys.order('created_at DESC')[1]
  			difference += last_user_survey.zytrip_rating - previous_user_survey.zytrip_rating
  		end

  		return difference
	end


end
