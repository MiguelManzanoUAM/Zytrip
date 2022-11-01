class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  #####################################################
  #Exporta todos los datos en un csv
  #####################################################
  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |friendship|
        csv << friendship.attributes.values_at(*fields)
      end
    end
  end

  #####################################################
  # Importa los datos desde un csv
  #####################################################
  def self.import
    path = Rails.root + "app/csv/friendships.csv"
    CSV.foreach(path, headers: true) do |row|
      friendship_hash = row.to_hash

      if !(Friendship.where("id" => friendship_hash['id']).exists?)
        user = User.find_by(id: friendship_hash['user_id'])
        friend = User.find_by(id: friendship_hash['friend_id'])

        if !(user.friends.include? friend)
          friendship = Friendship.create!(friendship_hash)
          friendship.save
        end
      end
      
    end
  end

  #####################################################
  # Añadimos un amigo a la lista del usuario
  #####################################################
  def self.add_friend(user, friend)

    if !(user.friends.include? friend)
      friendship = Friendship.create!(user_id: user.id, friend_id: friend.id)
      friendship.save
    end

  end

  #####################################################
  # Eliminamos un amigo de la lista del usuario
  #####################################################
  def self.delete_friend(user, friend)
    friendship = Friendship.find_by(user_id: user.id, friend_id: friend.id)

    if friendship
      friendship.destroy
    end


    if (user.friends.include? friend)
      user.friends.delete(friend)
    end

  end
end
