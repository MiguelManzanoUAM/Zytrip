class AddRelaxToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :relax, :boolean, default: false
  end
end
