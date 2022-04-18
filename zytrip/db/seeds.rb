# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Agency.destroy_all
Trip.destroy_all
User.destroy_all
Review.destroy_all

p "Borrando base de datos actual..."

User.create!(name:"Miguel", surname:"Admin", admin:true, password:"adminadmin", email:"miguel@email.es",
	password_confirmation:"adminadmin", id:1)

p "Se han creado un usuario administrador..."

User.create!(name:"Turista", surname:"prueba", admin:false, password:"manzano99", email:"prueba@email.es",
	password_confirmation:"manzano99", id:2)
Agency.create!(name:"Viajes Miguel", id:1)
Trip.create!(title: "Viaje prueba", body: "Descripcion del viaje", agency_id: 1, id:1)
Trip.create!(title: "Madrid", body: "Otra descripcion", agency_id: 1, id:2)
Review.create!(comment: "Me ha gustado mucho el viaje", rating: 4.5, user_id:2, trip_id:2, id:1)

p "Alimentando base de datos..."