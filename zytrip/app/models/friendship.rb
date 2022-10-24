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
end
