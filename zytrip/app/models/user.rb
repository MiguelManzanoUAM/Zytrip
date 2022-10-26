class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :trips
  has_many :reviews, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships
  
  #####################################################
  #Busqueda de usuarios mediante barra de busqueda
  #####################################################
  def self.search(search)
    if search
      where(["name like ?", "%#{search}%"])
    else
      all
    end
  end

  #####################################################
  #Exporta todos los datos en un csv
  #####################################################
  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |user|
        csv << user.attributes.values_at(*fields)
      end
    end
    #self.export_user_trips()
  end

  #####################################################
  #Exporta la asociación usuarios y viajes
  #####################################################
  def self.export_user_trips()
    path = Rails.root + "app/csv/users_trips.csv"
    
    CSV.open(path, "w") do |f|
      f << ["id", "trips"]
      User.all.each do |user|
        trips = self.visited_trips(user)
        if trips
          trips.each do |trip|
            f << [user.id, trip]
          end
        end
      end
    end
  end

  #####################################################
  #Importa los datos desde un csv
  #####################################################
  def self.import
    path = Rails.root + "app/csv/users.csv"
    CSV.foreach(path, headers: true) do |row|
      user_hash = row.to_hash
      if User.where("id" => user_hash['id']).exists?
        user = User.find_by(id: user_hash['id'])
      else
        user = User.create!(id: user_hash)
      end
      user.update(user_hash)
    end

    #self.import_trips()

  end

  #####################################################
  # Devuelve la lista de viajes del usuario
  #####################################################
  def self.visited_trips(user)
    trips = []

    Trip.all.each do |t|
      if t.users.include? user
        trips << t.id
      end
    end

    return trips
  end

  #####################################################
  # Importa los viajes de un usuario
  # ---------------------------------------------------
  # Por el momento no será necesario este método
  # ya que se añadirá la asociación viajes usuarios
  # con las reviews
  #####################################################
  def self.import_trips
    path = Rails.root + "app/csv/users_trips.csv"
    CSV.foreach(path, headers: true) do |row|
      user_hash = row.to_hash
      if User.where("id" => user_hash['id']).exists?
        user = User.find_by(id: user_hash['id'])
      end

      trip = Trip.find_by(id: user_hash['trips'])
      if !(user.trips.include? trip)
        user.trips << trip
        user.save
      end
    end
  end

  

  #####################################################
  # Obtenemos los viajes que ha realizado un usuario
  # junto a sus valoraciones
  #####################################################
  def self.user_trips_rating(user)
    user_reviews = Review.where(user_id: user.id)
    trips_with_rating = {}

    user_reviews.each do |review|
      trips_with_rating[review.trip_id] = review.rating
    end

    return trips_with_rating
  end

  #####################################################
  # Obtenemos todas las preferencias de un usuario
  # durante sus viajes
  #####################################################
  def self.user_trips_preferences(user)
    user_reviews = Review.where(user_id: user.id)
    trips = []
    preferences = []

    user_reviews.each do |review|
      trip = Trip.find_by(id: review.trip_id)
      trips << trip
    end

    trips.each do |trip|
      preferences_of_trip = Trip.trip_preferences(trip)
      preferences_of_trip.each do |pref|
        if !(preferences.include? pref)
          preferences << pref
        end
      end
    end

    return preferences
  end
  
  #####################################################
  # Algoritmo de recomendación por conocimiento
  # ---------------------------------------------------
  # 1) obtenemos todas las preferencias del usuario
  # 2) Creamos un hash {preferencia, importancia}
  # 3) Añadimos las preferencias como claves al hash
  # 4) Para cada viaje del usuario comprobamos si 
  #    tiene una preferencia y de ser así le sumamos a
  #    dicha preferencia su valoración
  # 5) Calculamos el total de los valores de las
  #    preferencias
  # 6) Asignamos a cada preferencia su importancia
  #    importancia = valor actual / total valores prefs
  #
  #####################################################
  def self.user_calculate_preferences(user)
    preferences = User.user_trips_preferences(user)
    trips = user.trips

    preferences_values = {}
    total_pref_rating = 0

    preferences.each do |pref|
      preferences_values[pref] = 0
    end

    trips.each do |trip|
      preferences.each do |pref|
        if Trip.trip_has_preference(trip, pref)
          preferences_values[pref] += Review.get_review(user, trip)
        end
      end
    end

    preferences_values.keys.each do |key|
      total_pref_rating += preferences_values[key]
    end

    preferences_values.keys.each do |key|
      preferences_values[key] = (preferences_values[key].to_f / total_pref_rating.to_f).round(3)
    end

    return preferences_values

  end

  #####################################################
  # Obtenemos las preferencias más relevantes de
  # un usuario
  #####################################################
  def self.valuable_preferences(user)
    preferences = User.user_calculate_preferences(user)
    final_preferences = []

    preferences_sorted = preferences.sort {|a1,a2| a2[1]<=>a1[1]}.to_h

    final_preferences = preferences_sorted.keys.first(3)

    return final_preferences
  end

  #####################################################
  # Obtenemos los viajes no realizados por el usuario
  #####################################################
  def self.not_visited_trips(user)
    trips = []

    Trip.all.each do |trip|
      if !(user.trips.include? trip)
        trips << trip
      end
    end

    return trips
  end

  #####################################################
  # Obtenemos la matriz de los candidatos de un usuario
  # ---------------------------------------------------
  # 1) Obtenemos los viajes que el usuario no ha hecho
  # 2) Construimos hash {viaje, {pref, valoracion}}
  #####################################################
  def self.user_candidate_preferences_matrix(user)
    trips = User.not_visited_trips(user)
    preferences = User.user_calculate_preferences(user)

    candidates = {}

    trips.each do |trip|
      candidates[trip.id] = {}

      preferences.each do |pref, value|
        if Trip.trip_has_preference(trip, pref)
          candidates[trip.id][pref] = value
        else
          candidates[trip.id][pref] = 0
        end
      end
    end

    return candidates

  end

  #####################################################
  # Obtenemos los viajes candidatos de un usuario
  # ---------------------------------------------------
  # El resultado será un hash {viaje, afinidad}
  # donde la afinidad será el resultado de sumar la
  # importancia de las preferencias que tiene el viaje
  #####################################################
  def self.user_candidate_preferences_afinity(user)
    candidates = User.user_candidate_preferences_matrix(user)
    afinities = {}

    candidates.keys.each do |trip|
      afinities[trip] = 0

      candidates[trip].keys.each do |pref|
        afinities[trip] += candidates[trip][pref]
      end
    end

    return afinities
  end

  #####################################################
  # Obtenemos los 3 viajes que más afinidad tengan con
  # el usuario siguiendo la técnica de recomendación
  # por conocimiento
  #####################################################
  def self.most_afinity_preferences_trips(user)
    candidates_affinity = User.user_candidate_preferences_afinity(user)
    candidates_sorted = candidates_affinity.sort {|a1,a2| a2[1]<=>a1[1]}.to_h

    candidates_ids = candidates_sorted.keys.first(3)
    candidates = []

    candidates_ids.each do |trip_id|
      candidates << Trip.find_by(id: trip_id)
    end

    return candidates
  end

end
