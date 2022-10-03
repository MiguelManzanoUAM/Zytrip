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


########################################
# Creación de Viajes
########################################
Trip.create!(title:"Viaje Prueba", organizer_id: 2)

########################################
# Creación de Preferencias
########################################


p "Pensando un precio para los viajes..."

p "Alimentando base de datos..."
########################################