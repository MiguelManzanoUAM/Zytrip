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

Trip.destroy_all
User.destroy_all
Review.destroy_all
Preference.destroy_all
Service.destroy_all
Topic.destroy_all
Company.destroy_all

p "Borrando base de datos actual..."
########################################

########################################
# Creación de un usuario administrador
########################################

User.create!(name:"Admin", surname:"User", admin:true, password:"adminadmin", email:"admin@email.es",
	password_confirmation:"adminadmin", id:1)

User.create!(name:"Nautilus", surname: "Viajes", admin:false, password:"nautilUs01", email:"nautilus@email.es", id:2, image:"users/nautilus.png", phone_number: "916528536")

User.create!(name:"Viajes", surname: "El Turista Inglés", admin:false, password:"turistaIngles02", email:"viajeselturistaingles@email.es", id:3, image:"users/turista_ingles.png", phone_number: "916832141")

p "Se están creando los primeros usuarios..."
p "Se han creado un usuario administrador..."
########################################


########################################
# Creación de Viajes
########################################

Trip.create!(title:"viaje1", organizer_id:2, id:1)
Trip.create!(title:"viaje2", organizer_id:2, id:2)

#user = User.find_by(id:2)
#trip1 = Trip.first
#trip2 = Trip.last
#user2 = User.find_by(id:3)

#user.trips << trip1
#user2.trips << trip2

#Trip.import()

########################################
# Creación de Preferencias
########################################

#Preference.import()
#Company.import()
#Topic.import()
#Service.import()

p "Pensando un precio para los viajes..."

p "Alimentando base de datos..."
########################################