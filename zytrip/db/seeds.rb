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

Agency.destroy_all
Trip.destroy_all
User.destroy_all
Review.destroy_all

p "Borrando base de datos actual..."
########################################

########################################
# Creación de un usuario administrador
########################################

User.create!(name:"Miguel", surname:"Admin", admin:true, password:"adminadmin", email:"miguel@email.es",
	password_confirmation:"adminadmin", id:1)

p "Se han creado un usuario administrador..."
########################################

########################################
# Creación de diferentes objetos para
# alimentar la base de datos
########################################

User.create!(name:"Turista", surname:"prueba", admin:false, password:"manzano99", email:"prueba@email.es",
	password_confirmation:"manzano99", id:2)

Agency.create!(name:"Viajes Miguel", id:1)
Agency.create!(name:"Viajes El Corte Inglés", id:2, phone_number:"913567892", url:"www.viajesElCorteIngles.es",
	logo:"elCorteIngles.png")

Trip.create!(title: "Viaje prueba", body: "Descripcion del viaje", agency_id: 1, id:1, image:"summer.jpeg", price:1050)
Trip.create!(title: "Madrid", body: "Otra descripcion", agency_id: 1, id:2, rating:5.0, image:"madrid.jpg", price:70)
Trip.create!(title: "Londres", body:"Descripción Londres", agency_id: 2, id:3, rating:4.5, image:"londres.jpg", price: 385)
Trip.create!(title: "Viaje prueba 2", body: "Descripcion del viaje 2", agency_id: 1, id:4, image:"user.jpeg", price: 10)

p "Pensando un precio para los viajes..."

Review.create!(comment: "Me ha gustado mucho el viaje", rating: 4.5, user_id:2, trip_id:2, id:1)

p "Alimentando base de datos..."
########################################