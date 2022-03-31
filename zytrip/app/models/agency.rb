class Agency < ApplicationRecord
	has_many :trips, dependent: :destroy

	#Busqueda de agencias mediante barra de busqueda
  	def self.search(search)
    	if search
      		where(["name like ?", "%#{search}%"])
    	else
      		all
    	end
  	end
end
