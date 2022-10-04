class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :trips
  has_many :reviews, dependent: :destroy
  
  #Busqueda de usuarios mediante barra de busqueda
  def self.search(search)
    if search
      where(["name like ?", "%#{search}%"])
    else
      all
    end
  end

  #Exporta todos los datos en un csv
  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |user|
        csv << user.attributes.values_at(*fields)
      end
    end
  end

  #Importa los datos desde un csv
  def self.import
    path = Rails.root + "app/csv/users.csv"
    CSV.foreach(path, headers: true) do |row|
      user_hash = row.to_hash
      if User.where("id" => user_hash['id']).exists?
        user = User.find_by(id: user_hash['id'])
      else
        user = User.create!(user_hash)
      end
      user.update(user_hash)
    end
  end
end
