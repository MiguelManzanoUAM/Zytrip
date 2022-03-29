# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Agency.destroy_all
Trip.destroy_all

p "Borrando base de datos actual..."

Agency.create!(name:"Viajes Miguel", id:1)
Trip.create!(title: "Viaje prueba", body: "Descripcion del viaje", agency_id: 1, id:1)

p "Alimentando base de datos..."