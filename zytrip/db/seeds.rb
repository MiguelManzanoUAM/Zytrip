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
Preference.destroy_all
Service.destroy_all
Topic.destroy_all
Company.destroy_all

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
# Creación de usuarios
########################################

User.create!(name:"Turista", surname:"prueba", admin:false, password:"manzano99", email:"prueba@email.es",
	password_confirmation:"manzano99", id:2)

########################################
# Creación de algunas Agencias
########################################

Agency.create!(name:"Viajes Miguel", id:1, phone_number:"653209970")
Agency.create!(name:"Viajes El Corte Inglés", id:2, phone_number:"913567892", url:"www.viajesElCorteIngles.es",
	logo:"elCorteIngles.png")

########################################
# Creación de Viajes
########################################

Trip.create!(title: "Viaje prueba", body: "Descripcion del viaje", agency_id: 1, id:1, rating:2.1, image:"summer.jpeg", price:1050, country:"Over the Rainbow", city:"Somewhere", 
	description:"Get an inside look into traditional sustainable farming and its impact on the coffee industry. You’ll learn about every stage of the production process, from growing to roasting, by our local experts who’ll take you on a walk-through of a scenic farm, explain how the slopes of Volcan Baru make the world’s best coffee, and show you how to brew a delicious cup. You’ll also get free hotel pick-up and drop-off, bottled water, and a custom bag of whole beans to take home. ")
Trip.create!(title: "Madrid", body: "Otra descripcion", agency_id: 1, id:2, rating:5.0, image:"madrid.jpg", price:70, country:"España", city:"Madrid")
Trip.create!(title: "Londres", body:"Descripción Londres", agency_id: 2, id:3, rating:4.5, image:"londres.jpg", price: 385, country:"Reino Unido", city:"Londres")
Trip.create!(title: "Viaje prueba 2", body: "Descripcion del viaje 2", agency_id: 1, id:4, rating:2.0, price: 10, country:"Prueba", city:"prueba")

########################################
# Creación de Preferencias
########################################


Preference.create!(id:1, destination:3, budget:3, duration: 3, trip_id: 1)
Preference.create!(id:2, destination:0, budget:0, duration: 0, trip_id: 2)
Preference.create!(id:3, destination:1, budget:1, duration: 1, trip_id: 3)
Preference.create!(id:4, destination:3, budget:0, duration: 3, trip_id:4)

Service.create!(id:1, gastronomy: true, lodging: true, activities: false, preference_id:1)
Company.create!(id:1, family:true, preference_id:1)
Topic.create!(id:1, nature:true, preference_id:1)

Service.create!(id:2, gastronomy: true, lodging: false, activities: false, preference_id:2)
Company.create!(id:2, alone:true, preference_id:2)
Topic.create!(id:2, beach:true, preference_id:2)

Service.create!(id:3, gastronomy: false, lodging: false, activities: true, preference_id:3)
Company.create!(id:3, romantic:true, preference_id:3)
Topic.create!(id:3, tourism:true, preference_id:3)

Service.create!(id:4, gastronomy: false, lodging: true, activities:false, preference_id:4)
Company.create!(id:4, people:true, preference_id:4)
Topic.create!(id:4, nature:true, preference_id:4)


p "Pensando un precio para los viajes..."

Review.create!(comment: "Me ha gustado mucho el viaje", rating: 4.5, user_id:2, trip_id:2, id:1)

p "Alimentando base de datos..."
########################################