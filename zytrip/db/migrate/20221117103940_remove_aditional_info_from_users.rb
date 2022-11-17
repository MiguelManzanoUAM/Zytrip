class RemoveAditionalInfoFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phone_number, :string
    remove_column :users, :slogan, :string
    remove_column :users, :description, :string
    remove_column :users, :image_url, :string
  end
end
