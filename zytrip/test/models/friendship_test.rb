require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  #####################################################
  # Inicializacion previa a los test
  #####################################################

  puts "-> Test Amistades"

  setup do
    @user_one = User.new(id: 1, name:"User", surname:"One", email:"useremailone@outlook.es", password:"UserOne111", password_confirmation:"UserOne111", admin:false)
    @user_one.save
    @user_two = User.new(id: 2, name:"User", surname:"Two", email:"useremailtwo@outlook.es", password:"UserTwo222", password_confirmation:"UserTwo222", admin:false)
    @user_two.save
    @friendship = Friendship.new
    
  end

  #####################################################
  # Comprobar que un usuario aun no tiene amigos
  # ---------------------------------------------------
  # El test comprueba que el usuario recien creado
  # tiene su lista de amigos vacia
  #####################################################
  def test_user_has_no_friends
    assert_equal @user_one.friends.size, 0, "La lista de amigos del usuario no está vacía"
  end

  #####################################################
  # Usuario uno se hace amigo de usuario dos
  # ---------------------------------------------------
  # El test comprueba que el usuario añade al usuario
  # dos a su lista de amigos
  #####################################################
  def test_user_add_friend
    Friendship.add_friend(@user_one, @user_two)
    assert_not_equal @user_one.friends.size, 0, "la lista de amigos del usuario sigue vacía"
  end

  #####################################################
  # Usuario uno borra a usuario dos de sus amigos
  # ---------------------------------------------------
  # El test comprueba que el usuario elimina al usuario
  # dos de su lista de amigos
  #####################################################
  def test_user_delete_friend
    Friendship.add_friend(@user_one, @user_two)
    Friendship.delete_friend(@user_one, @user_two)
    assert_equal @user_one.friends.size, 0, "la lista de amigos del usuario no ha cambiado"
  end

end
