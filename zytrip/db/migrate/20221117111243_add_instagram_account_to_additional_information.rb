class AddInstagramAccountToAdditionalInformation < ActiveRecord::Migration[7.0]
  def change
    add_column :additional_informations, :instagram_nickname, :string
  end
end
