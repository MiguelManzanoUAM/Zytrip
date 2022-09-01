class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.boolean :lodging, default: :false
      t.boolean :gastronomy, default: :false
      t.boolean :activities, default: :false
      t.references :preference, null: false, foreign_key: true
      t.timestamps
    end
  end
end
