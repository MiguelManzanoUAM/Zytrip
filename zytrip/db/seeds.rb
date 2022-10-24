# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

########################################
# Borrado de la base de datos
########################################

Friendship.destroy_all
Service.destroy_all
Topic.destroy_all
Company.destroy_all
Review.destroy_all
Preference.destroy_all
Trip.destroy_all
User.destroy_all

p "Borrando base de datos actual..."
########################################

########################################
# Creación de un usuario administrador
########################################

User.create!(name:"Admin", surname:"User", admin:true, password:"adminadmin", email:"admin@email.es",
	password_confirmation:"adminadmin", id:1)

User.create!(name:"Nautilus", surname: "Viajes", admin:false, password:"nautilUs01", email:"nautilus@email.es", id:2, image:"users/nautilus.png", phone_number: "916528536")

User.create!(name:"Viajes", surname: "El Turista Inglés", admin:false, password:"turistaIngles02", email:"viajeselturistaingles@email.es", id:3, image:"users/turista_ingles.png", phone_number: "916832141")


User.create!(id: 4, name:"Marisol", surname:"del Bayo", email:"maribayo@outlook.es", phone_number: "666263369", password:"baYosol61", admin:false)
User.create!(id: 5, name:"Germán", surname:"Menéndez", email:"gemendez@outlook.es", phone_number: "698978314", password:"mendeZdeZ", admin:false)
User.create!(id: 6, name:"Jose", surname:"Cid Arango", email:"josecarango@hotmail.es", password:"arangoCid87", admin:false)
User.create!(id: 7, name:"Sergio", surname:"Vizcaíno", email:"sergiovz@outlook.es", phone_number: "668533815", password:"vizcaSrgo", admin:false)
User.create!(id: 8, name:"Valeria", surname:"Madrigal", email:"valmagal@outlook.es", password:"Valevalem95", admin:false)
User.create!(id: 9, name:"Soraya", surname:"Cardona", email:"scardona@yahoo.es", phone_number: "608912490", password:"Sorydona97", admin:false)
User.create!(id: 10, name:"Iker", surname:"Nilo Vaquero", email:"ikernilovaq@hotmail.es", password:"niloVaqIkerR", admin:false)
User.create!(id: 11, name:"Édgar", surname:"Cortés", email:"edgarcortesp@outlook.es", phone_number: "660338105", password:"CortesPartn96", admin:false)
User.create!(id: 12, name:"Julián", surname:"Palomino", email:"jpalomino@outlook.es", phone_number: "620122294", password:"butrpalmjN22", admin:false)
User.create!(id: 13, name:"Gabriel", surname:"Galindo", email:"gabgalindo@hotmail.es", phone_number: "684404469", password:"gGaldrielDo05", admin:false)
User.create!(id: 14, name:"Cristina", surname:"Galán Bautista", email:"cristigalan@outlook.es", phone_number: "677996045", password:"bauCrGalan", admin:false)
User.create!(id: 15, name:"Lorenzo", surname:"Anglada", email:"lordanglada@hotmail.es", password:"angManjLor92", admin:false)
User.create!(id: 16, name:"Sara", surname:"Valenzuela", email:"saritavalen@hotmail.es", password:"ValenzaRa99", admin:false)
User.create!(id: 17, name:"Águeda", surname:"del Carpio", email:"aguedelcarpio@outlook.es", phone_number: "639969489", password:"dCarpGuedA", admin:false)
User.create!(id: 18, name:"Jaime", surname:"Mendoza", email:"jmendoza@hotmail.es", phone_number: "616725586", password:"menBerger97", admin:false)
User.create!(id: 19, name:"Lara", surname:"Lorenzo", email:"laraenzo@outlook.es", password:"renzoiZaguirre99", admin:false)
User.create!(id: 20, name:"Flavio", surname:"Palma", email:"flapalma@outlook.es", phone_number: "605573698", password:"palmaBillarFla98", admin:false)

p "Se están creando los primeros usuarios..."
p "Se han creado un usuario administrador..."
########################################


########################################
# Creación de Viajes
########################################

#Trip.create!(title:"viaje1", organizer_id:2, id:1)
#Trip.create!(title:"viaje2", organizer_id:2, id:2)

#user = User.find_by(id:2)
#trip1 = Trip.first
#trip2 = Trip.last
#user2 = User.find_by(id:3)

#user.trips << trip1
#user2.trips << trip2

Trip.import()

########################################
# Creación de Preferencias
########################################

Review.import()
Preference.import()
Company.import()
Topic.import()
Service.import()

p "Pensando un precio para los viajes..."

p "Alimentando base de datos..."
########################################