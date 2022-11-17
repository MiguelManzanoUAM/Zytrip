class CreateAdditionalInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :additional_informations do |t|
      t.string :phone_number
      t.string :slogan
      t.text :description
      t.string :image_url
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
