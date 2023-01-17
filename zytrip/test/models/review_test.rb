require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  #####################################################
  # Inicializacion previa a los test
  #####################################################

  puts "\n-> Test Valoración de un viaje"

  setup do
    @user_one = User.new(id: 0, name:"User", surname:"One", email:"useremailone@outlook.es", password:"UserOne111", password_confirmation:"UserOne111", admin:false)
    @user_one.save
    @user_two = User.new(id: 1, name:"User", surname:"Two", email:"useremailtwo@outlook.es", password:"UserTwo222", password_confirmation:"UserTwo222", admin:false)
    @user_two.save
    @trip_one = Trip.new(id: 0, organizer_id: @user_one.id, title: "Trip One", description: "Description for trip one", subtitle:"Subtitle for trip one", price: 250)
    @trip_one.save
    @review_one = Review.new(id: 0, user_id: @user_two.id, trip_id: @trip_one.id, rating: 4, comment: "Valoracion uno")
    @review_one.save
  end

  #####################################################
  # Comprobar que usuario dos no tiene viajes
  # ---------------------------------------------------
  # El test comprueba que el usuario dos tiene su lista
  # de viajes vacía, es decir no ha realizado ninguna
  # review aún
  #####################################################
  def test_user_has_no_trips
    assert_equal @user_two.trips.size, 0, "El usuario ya ha realizado algun viaje"
  end

  def test_user_has_review
    assert_not_equal @user_two.reviews.size, 0, "El usuario no ha realizado reviews"
    assert_not_equal @trip_one.reviews.size, 0, "El viaje no tiene reviews"
  end

  #####################################################
  # Usuario realiza una review
  # ---------------------------------------------------
  # El test comprueba que un usuario realiza una
  # valoracion del viaje uno de forma correcta y este
  # se añade a su lista de viajes
  #####################################################
  def test_user_make_a_review
    Review.add_user_to_trip(@review_one)
    assert_not_equal @user_two.trips.size, 0, "No se ha añadido el viaje a la lista de viajes del usuario"
  end

  #####################################################
  # Usuario realiza una nueva review
  # ---------------------------------------------------
  # El test comprueba que un usuario puede valorar
  # varias veces un mismo viaje sin que este se añada
  # de nuevo a la lista, y las valoraciones son
  # permanentes
  #####################################################
  def test_user_make_second_review
    @review_two = Review.new(id: 1, user_id: @user_two.id, trip_id: @trip_one.id, rating: 3, comment: "Valoracion dos")
    @review_two.save
    Review.add_user_to_trip(@review_two)
    assert_not_equal @user_two.trips.size, 2, "Se ha añadido mas de una vez el viaje"
    assert_equal @user_two.reviews.size, 2, "No se han guardado ambas valoraciones"
  end
end
