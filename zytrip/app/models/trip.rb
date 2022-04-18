class Trip < ApplicationRecord
	belongs_to :agency
	has_and_belongs_to_many :users
	has_many :reviews, dependent: :destroy

	#Busqueda de viajes mediante barra de busqueda
  	def self.search(search)
    	if search
      		where(["title like ?", "%#{search}%"])
    	else
      		all
    	end
  	end
end
