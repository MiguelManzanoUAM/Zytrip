class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #Busqueda de usuarios mediante barra de busqueda
  def self.search(search)
    if search
      where(["name like ?", "%#{search}%"])
    else
      all
    end
  end
end
