class ChangePricesType < ActiveRecord::Migration[7.0]
  def change
    change_column :trips, :price, :integer
  end
end
