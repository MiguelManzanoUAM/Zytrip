class AddUserToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_reference :surveys, :user, foreign_key: true
  end
end
