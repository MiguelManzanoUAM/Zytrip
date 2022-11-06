class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.text :comment
      t.decimal :results_rating
      t.decimal :zytrip_rating
      t.decimal :preferences_poll_rating
      t.timestamps
    end
  end
end
