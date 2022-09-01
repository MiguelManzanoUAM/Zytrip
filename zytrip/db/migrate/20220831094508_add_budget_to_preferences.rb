class AddBudgetToPreferences < ActiveRecord::Migration[7.0]
  def change
    add_column :preferences, :budget, :integer, default: 0
  end
end
