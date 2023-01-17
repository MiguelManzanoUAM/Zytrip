require "test_helper"

class UserTest < ActiveSupport::TestCase

  #####################################################
  # Inicializacion previa a los test
  #####################################################

  puts "-> Test Usuarios"

  setup do
    @empty_user = User.new(id: 0, name: "Empty", surname: "User", email: "emptyuseremail", password: "empty", password_confirmation: "empty000")
    @user_one = User.new(id: 1, name:"User", surname:"One", email:"useremailone@outlook.es", password:"UserOne111", password_confirmation:"UserOne111", admin:false)
    @user_one.save
  end

  #####################################################
  # Creación de un usuario incorrecto
  # ---------------------------------------------------
  # El test comprueba que no se pueda guardar al
  # usuario empty, al no cumplir este las validaciones
  # necesarias de correo y contraseña
  #####################################################
  def test_create_empty_user
    assert_not @empty_user.save, "El usuario sí cumple las validaciones"
  end

  #####################################################
  # Creación de un usuario
  # ---------------------------------------------------
  # El test comprueba que se pueda guardar al
  # usuario one, al cumplir este las validaciones
  # necesarias el test será válido
  #####################################################
  def test_create_user
    assert_not_nil @user_one.save, "El usuario no cumple las validaciones"
  end

end
