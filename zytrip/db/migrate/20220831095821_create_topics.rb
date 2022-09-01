class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.boolean :beach, default: :false
      t.boolean :nature, default: :false
      t.boolean :tourism, default: :false
      t.references :preference, null: false, foreign_key: true
      t.timestamps
    end
  end
end
