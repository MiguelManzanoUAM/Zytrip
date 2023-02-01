require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  #####################################################
  # Inicializacion previa a los test
  #####################################################

  puts "-> Test encuesta de usuario"

  setup do
    @user_one = User.new(id: 0, name:"User", surname:"One", email:"useremailone@outlook.es", password:"UserOne111", 
      password_confirmation:"UserOne111", admin:false)
    @user_one.save

    @user_two = User.new(id: 1, name:"User", surname:"Two", email:"useremailtwo@outlook.es", password:"UserTwo222", 
      password_confirmation:"UserTwo222", admin:false)
    @user_two.save
  end

  #####################################################
  # Comprobar que no hay encuestas realizadas
  # ---------------------------------------------------
  # El test comprueba que el usuario uno no ha 
  # realizado ninguna encuesta de usuario
  #####################################################
  def test_user_has_no_surveys
    assert_equal @user_one.surveys.size, 0, "El usuario ya ha realizado alguna encuesta"
  end

  #####################################################
  # El usuario rellena la encuesta de satisfacción
  # ---------------------------------------------------
  # El test comprueba que el usuario rellena de forma
  # correcta la encuesta de usuario y esta se añade a
  # a su lista de encuestas realizadas
  # A su vez, comprueba que estas persisten también en
  # el sistema
  #####################################################
  def test_user_make_survey
    @survey_one = Survey.new(id: 0, user_id: @user_one.id, results_rating: 3, preferences_poll_rating: 4, 
      zytrip_rating: 4, comment: "Comentario uno")
    @survey_one.save
    assert_not_equal @user_one.surveys.size, 0, "Error al realizar la encuesta"
    @latest_surveys = Survey.get_latest_surveys()
    assert_not_nil @latest_surveys, "No se han rellenado encuestas ultimamente"
  end

end

