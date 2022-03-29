class CreateAgencies < ActiveRecord::Migration[7.0]
  def change
    create_table :agencies do |t|
      t.string :name

      t.timestamps
    end
  end
end
