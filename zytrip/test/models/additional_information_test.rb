require "test_helper"

class AdditionalInformationTest < ActiveSupport::TestCase
  #####################################################
  # Inicializacion previa a los test
  #####################################################

  puts "\n-> Test perfil usuario"

  setup do
    @user_one = User.new(id: 1, name:"User", surname:"One", email:"useremailone@outlook.es", password:"UserOne111", password_confirmation:"UserOne111", admin:false)
    @user_one.save
    @user_two = User.new(id: 2, name:"User", surname:"Two", email:"useremailtwo@outlook.es", password:"UserTwo222", password_confirmation:"UserTwo222", admin:false)
    @user_two.save
    @profile_wrong = AdditionalInformation.new(id: 0, user_id: 1, phone_number: "91652a", instagram_nickname: "@useroneinsta")
    @profile_two = AdditionalInformation.new(id: 0, user_id: 2, phone_number: "916522345", instagram_nickname: "@usertwoinsta")
    @profile_two.save
  end

  #####################################################
  # Comprobar que aun no tiene informacion adicional
  # ---------------------------------------------------
  # El test comprueba que el usuario aun no cuenta con
  # ninguna informacion adicional, es decir no ha
  # completado su perfil
  #####################################################
  def test_user_has_no_additional_info
    assert_nil @user_one.additional_information, "El usuario ya cuenta con informacion adicional"
  end

  #####################################################
  # Creación de información adicional incorrecta
  # ---------------------------------------------------
  # El test comprueba que el usuario rellena de forma
  # incorrecta su perfil, no cumpliendo las validación
  # del número de teléfono
  #####################################################
  def test_wrong_additional_info_validation
    assert_not @profile_wrong.save, "Se cumplen las validaciones"
  end

  #####################################################
  # Creación de información adicional correcta
  # ---------------------------------------------------
  # El test comprueba que el usuario dos rellena de 
  # forma correcta su perfil
  #####################################################
  def test_additional_info_validation
    assert_not_nil @user_two.additional_information, "No se cumplen las validaciones"
  end


end
