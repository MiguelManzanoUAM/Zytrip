class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.boolean :family, default: :false
      t.boolean :romantic, default: :false
      t.boolean :friends, default: :false
      t.boolean :alone, default: :false
      t.boolean :people, default: :false
      t.references :preference, null: false, foreign_key: true
      t.timestamps
    end
  end
end
