require "test_helper"

class TripTest < ActiveSupport::TestCase
  #####################################################
  # Inicializacion previa a los test
  #####################################################

  puts "-> Test Viajes"

  setup do
  	@user_one = User.new(id: 0, name:"User", surname:"One", email:"useremailone@outlook.es", password:"UserOne111", password_confirmation:"UserOne111", admin:false)
    @user_one.save
    @trip_one = Trip.new(id: 0, organizer_id: @user_one.id, title: "Trip One", description: "Description for trip one", subtitle:"Subtitle for trip one", price: 250, rating: 0)
    @trip_one.save
  end

  #####################################################
  # Crear un viaje de forma incorrecta
  # ---------------------------------------------------
  # El test comprueba que se crea un viaje de forma
  # incorrecta, no cumpliendo las validaciones
  # correspondientes
  #####################################################
  def test_trip_validation_error
  	@trip_error = Trip.new(id: 0, organizer_id: @user_one.id, title: "Trip Error", description: "Description for trip error", subtitle:"Subtitle for trip one", price: "price", rating: 0)
    assert_not @trip_error.save, "El viaje se ha creado de forma correcta"
  end

  #####################################################
  # Crear un viaje de forma correcta
  # ---------------------------------------------------
  # El test comprueba que se crea un viaje de forma
  # correcta, asignando las correspondientes
  # preferencias y comprobando que el viaje se guarda
  # en la lista de viajes del usuario
  #####################################################
  def test_create_trip
  	assert_not_nil @trip_one, "Error al crear el viaje"
  	assert_nil @trip_one.preference, "El viaje ya cuenta con preferencias asignadas"

  	@preference_one = Preference.new(id: 0, trip_id: @trip_one.id, destination: 0, budget: 2, duration: 1)
  	@preference_one.save
  	assert_not_nil @preference_one, "Error al asignar las preferencias básicas"

  	@company_one = Company.new(id: 0, preference_id: @preference_one.id, family: false, romantic: true, friends: false, alone: true, people:false)
  	@company_one.save
  	@service_one = Service.new(id: 0, preference_id: @preference_one.id, lodging: false, gastronomy: true, activities: false)
  	@service_one.save
  	@topic_one = Topic.new(id: 0, preference_id: @preference_one.id, beach: false, nature: true, tourism: false, relax: true)
  	@topic_one.save

  	assert_not @preference_one.remarkable_lodging?, "Error al asignar los servicios del viaje"
  	assert @preference_one.alone_as_company?, "Error al asignar el tipo de viaje" 
  	assert_not @preference_one.tourism_as_main_topic?, "Error al asignar las tematicas del viaje"
  end


end
