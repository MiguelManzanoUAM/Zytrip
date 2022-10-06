class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :trips
  has_many :reviews, dependent: :destroy
  
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
end
