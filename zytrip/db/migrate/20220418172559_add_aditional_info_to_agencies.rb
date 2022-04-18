class AddAditionalInfoToAgencies < ActiveRecord::Migration[7.0]
  def change
    add_column :agencies, :url, :string
    add_column :agencies, :logo, :string
    add_column :agencies, :phone_number, :string
    add_column :agencies, :description, :text
  end
end
