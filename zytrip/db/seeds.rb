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

AdditionalInformation.destroy_all
Survey.destroy_all
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

User.create!(name:"Admin", surname:"User", admin:true, password:"AdminAdmin99", email:"admin@email.es",
	password_confirmation:"AdminAdmin99", id:1)

User.create!(name:"Nautilus", surname: "Viajes", admin:false, password:"nautilUs01", password_confirmation:"nautilUs01", email:"nautilus@email.es", id:2, image:"users/nautilus.png")
User.create!(name:"Viajes", surname: "El Turista Inglés", admin:false, password:"turistaIngles02", password_confirmation:"turistaIngles02", email:"viajeselturistaingles@email.es", id:3, image:"users/turista_ingles.png")

User.create!(id: 4, name:"Marisol", surname:"del Bayo", email:"maribayo@outlook.es", password:"baYosol61", password_confirmation:"baYosol61", admin:false)
User.create!(id: 5, name:"Germán", surname:"Menéndez", email:"gemendez@outlook.es", password:"mendeZ5deZ", password_confirmation:"mendeZ5deZ", admin:false)
User.create!(id: 6, name:"Jose", surname:"Cid Arango", email:"josecarango@hotmail.es", password:"arangoCid87", password_confirmation:"arangoCid87", admin:false)
User.create!(id: 7, name:"Sergio", surname:"Vizcaíno", email:"sergiovz@outlook.es", password:"vizcaS3rgo", password_confirmation:"vizcaS3rgo", admin:false)
User.create!(id: 8, name:"Valeria", surname:"Madrigal", email:"valmagal@outlook.es", password:"Valevalem95", password_confirmation:"Valevalem95", admin:false)
User.create!(id: 9, name:"Soraya", surname:"Cardona", email:"scardona@yahoo.es", password:"Sorydona97", password_confirmation:"Sorydona97", admin:false)
User.create!(id: 10, name:"Iker", surname:"Nilo Vaquero", email:"ikernilovaq@hotmail.es", password:"niloVaq1kerR", password_confirmation:"niloVaq1kerR", admin:false)
User.create!(id: 11, name:"Édgar", surname:"Cortés", email:"edgarcortesp@outlook.es", password:"CortesPartn96", password_confirmation:"CortesPartn96", admin:false)
User.create!(id: 12, name:"Julián", surname:"Palomino", email:"jpalomino@outlook.es", password:"butrpalmjN22", password_confirmation:"butrpalmjN22", admin:false)
User.create!(id: 13, name:"Gabriel", surname:"Galindo", email:"gabgalindo@hotmail.es", password:"gGaldrielDo05", password_confirmation:"gGaldrielDo05", admin:false)
User.create!(id: 14, name:"Cristina", surname:"Galán Bautista", email:"cristigalan@outlook.es", password:"bauCr6alan", password_confirmation:"bauCr6alan", admin:false)
User.create!(id: 15, name:"Lorenzo", surname:"Anglada", email:"lordanglada@hotmail.es", password:"angManjLor92", password_confirmation:"angManjLor92", admin:false)
User.create!(id: 16, name:"Sara", surname:"Valenzuela", email:"saritavalen@hotmail.es", password:"ValenzaRa99", password_confirmation:"ValenzaRa99", admin:false)
User.create!(id: 17, name:"Águeda", surname:"del Carpio", email:"aguedelcarpio@outlook.es", password:"dCarp6uedA", password_confirmation:"dCarp6uedA", admin:false)
User.create!(id: 18, name:"Jaime", surname:"Mendoza", email:"jmendoza@hotmail.es", password:"menBerger97", password_confirmation:"menBerger97", admin:false)
User.create!(id: 19, name:"Lara", surname:"Lorenzo", email:"laraenzo@outlook.es", password:"renzoiZaguirre99", password_confirmation:"renzoiZaguirre99", admin:false)
User.create!(id: 20, name:"Flavio", surname:"Palma", email:"flapalma@outlook.es", password:"palmaBillarFla98", password_confirmation:"palmaBillarFla98", admin:false)
User.create!(id: 21, name:"Luis", surname:"Salmerón", email:"lusalmon@outlook.es", admin: false, password:"salmeUi99s", password_confirmation:"salmeUi99s")

User.create!(id: 22, name:"Reading", surname:".yeah", email:"reading@email.com", admin: false, image:"local/reading_logo.png", password:"reaDingYeah03", password_confirmation:"reaDingYeah03")
p "Se están creando los primeros usuarios..."
p "Se ha creado un usuario administrador..."
########################################

Trip.import()
Review.import()
Preference.import()
Company.import()
Topic.import()
Service.import()
Friendship.import()
Survey.import()
AdditionalInformation.import()

p "Pensando un precio para los viajes..."

p "Alimentando base de datos..."
########################################