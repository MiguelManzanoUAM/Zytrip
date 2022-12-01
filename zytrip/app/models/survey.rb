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
  	# Dada una encuesta devuelve el usuario que la ha
  	# realizado
  	#####################################################
  	def self.get_user_survey(survey)
  		user_survey = User.find_by(id: survey.user_id)

  		return user_survey
  	end

  	#####################################################
  	# Obtiene la valoración que un usuario ha dado
  	# en la encuesta. Al poder haber realizado más de una
  	# se tendrá en cuenta la última realizada
  	#####################################################
  	def self.get_last_user_survey(user)
  		surveys = Survey.where(user_id: user.id)

  		if surveys.size == 1
  			return surveys.first
  		else
  			return surveys.order('created_at DESC').first
  		end
  	end

  	#####################################################
  	# Obtiene la valoración media de una encuesta
  	#####################################################
  	def self.get_survey_media_rating(survey)
  		media = 0.0

  		media += ((survey.results_rating + survey.preferences_poll_rating + survey.zytrip_rating).to_f/3.0).round(2)

  		return media
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
  			survey = Survey.get_last_user_survey(user)

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
  			survey = Survey.get_last_user_survey(user)

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
  			survey = Survey.get_last_user_survey(user)

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
  	def self.get_users_results_rating_improved_percentage
  		rating_improved = 0
  		percentage = 0.0
  		users_with_various_surveys = Survey.get_users_with_various_surveys

  		if users_with_various_surveys.size != 0
	  		users_with_various_surveys.each do |user|
	  			user_surveys = Survey.where(user_id: user.id)
	  			last_user_survey = user_surveys.order('created_at DESC').first
	  			previous_user_survey = user_surveys.order('created_at DESC')[1]
	  			
	  			if last_user_survey.results_rating > previous_user_survey.results_rating
	  				rating_improved += 1
	  			elsif last_user_survey.results_rating < previous_user_survey.results_rating
	  				rating_improved -= 1
	  			elsif ((last_user_survey.results_rating == 5 ) && (previous_user_survey.results_rating == 5))
	  				rating_improved +=1
	  			else
	  				rating_improved += 0
	  			end
	  		end

	  		percentage = (rating_improved.to_f/users_with_various_surveys.size.to_f)*100
	  	end

  		return percentage.round(2)
  		
	end

	#####################################################
  	# Calcula el porcentaje de mejora respecto a la 
  	# valoración de las búsquedas de los usuarios
  	#####################################################
  	def self.get_users_searches_rating_improved_percentage
  		rating_improved = 0
  		users_with_various_surveys = Survey.get_users_with_various_surveys

  		if users_with_various_surveys.size != 0
	  		users_with_various_surveys.each do |user|
	  			user_surveys = Survey.where(user_id: user.id)
	  			last_user_survey = user_surveys.order('created_at DESC').first
	  			previous_user_survey = user_surveys.order('created_at DESC')[1]
	  			
	  			if last_user_survey.preferences_poll_rating > previous_user_survey.preferences_poll_rating
	  				rating_improved += 1
	  			elsif last_user_survey.preferences_poll_rating < previous_user_survey.preferences_poll_rating
	  				rating_improved -= 1
	  			elsif ((last_user_survey.preferences_poll_rating == 5 ) && (previous_user_survey.preferences_poll_rating == 5))
	  				rating_improved +=1
	  			else
	  				rating_improved += 0
	  			end
	  		end

	  		percentage = (rating_improved.to_f/users_with_various_surveys.size.to_f)*100
	  	end

  		return percentage.round(2)
	end

	#####################################################
  	# Calcula el porcentaje de mejora respecto a la 
  	# valoración de zytrip de los usuarios
  	#####################################################
  	def self.get_users_zytrip_rating_improved_percentage
  		rating_improved = 0
  		users_with_various_surveys = Survey.get_users_with_various_surveys

  		if users_with_various_surveys.size != 0
	  		users_with_various_surveys.each do |user|
	  			user_surveys = Survey.where(user_id: user.id)
	  			last_user_survey = user_surveys.order('created_at DESC').first
	  			previous_user_survey = user_surveys.order('created_at DESC')[1]
	  			
	  			if last_user_survey.zytrip_rating > previous_user_survey.zytrip_rating
	  				rating_improved += 1
	  			elsif last_user_survey.zytrip_rating < previous_user_survey.zytrip_rating
	  				rating_improved -= 1
	  			elsif ((last_user_survey.zytrip_rating == 5 ) && (previous_user_survey.zytrip_rating == 5))
	  				rating_improved +=1
	  			else
	  				rating_improved += 0
	  			end
	  		end

	  		percentage = (rating_improved.to_f/users_with_various_surveys.size.to_f)*100
	  	end

  		return percentage.round(2)
	end

	#####################################################
  	# Obtiene las encuestas que tengan alguna de las
  	# valoraciones baja para poder valorarlas
  	#####################################################
  	def self.get_lowest_rating_surveys
  		users_last_surveys = []
  		lowest_rating_surveys = []
  		low_result_survey_flag = 0
  		low_search_survey_flag = 0
  		low_zytrip_survey_flag = 0
  		low_media_rating_survey_flag = 0

  		User.all.each do |user|
  			last_survey = Survey.get_last_user_survey(user)

  			if last_survey
  				users_last_surveys << last_survey
  			end
  		end

  		surveys_with_low_results_rating = users_last_surveys.sort_by{|survey| survey.results_rating}
  		surveys_with_low_searches_rating = users_last_surveys.sort_by{|survey| survey.preferences_poll_rating}
  		surveys_with_low_zytrip_rating = users_last_surveys.sort_by{|survey| survey.zytrip_rating}

  		# nos interesa la peor encuesta de cada valoración y en caso de tenerla ya
  		# tomamos la siguiente peor. Recalcar a su vez que nos interesan aquellas que
  		# tengan un comentario sino no sirve de mucha ayuda

  		if !(lowest_rating_surveys.include? surveys_with_low_results_rating.first)
  			if surveys_with_low_results_rating.first.comment
	  			lowest_rating_surveys << surveys_with_low_results_rating.first
	  			low_result_survey_flag += 1
	  		end
  		end

		surveys_with_low_results_rating.each do |survey|
			if (!(lowest_rating_surveys.include? survey) && (low_result_survey_flag < 3))
				if survey.comment
					if Survey.get_survey_media_rating(survey) < 3.5
						lowest_rating_surveys << survey
						low_result_survey_flag += 1
					end
				end
			end
		end

  		if !(lowest_rating_surveys.include? surveys_with_low_searches_rating.first)
  			if surveys_with_low_searches_rating.first.comment
	  			lowest_rating_surveys << surveys_with_low_searches_rating.first
	  			low_search_survey_flag += 1
	  		end
  		end

		surveys_with_low_searches_rating.each do |survey|
			if (!(lowest_rating_surveys.include? survey) && (low_search_survey_flag < 3))
				if survey.comment
					if Survey.get_survey_media_rating(survey) < 3.5
						lowest_rating_surveys << survey
						low_search_survey_flag += 1
					end
				end
			end
		end

  		if !(lowest_rating_surveys.include? surveys_with_low_zytrip_rating.first)
  			if surveys_with_low_zytrip_rating.first.comment
	  			lowest_rating_surveys << surveys_with_low_zytrip_rating.first
	  			low_zytrip_survey_flag += 1
	  		end
  		end

		surveys_with_low_zytrip_rating.each do |survey|
			if (!(lowest_rating_surveys.include? survey) && (low_zytrip_survey_flag < 3))
				if survey.comment
					if Survey.get_survey_media_rating(survey) < 3.5
						lowest_rating_surveys << survey
						low_zytrip_survey_flag += 1
					end
				end
			end
		end

  		return lowest_rating_surveys
  	end

  	#####################################################
  	# Obtiene las últimas encuestas realizadas
  	#####################################################
  	def self.get_latest_surveys
  		latest_surveys = Survey.order('created_at DESC')

  		return latest_surveys.first(9)
  	end

end
