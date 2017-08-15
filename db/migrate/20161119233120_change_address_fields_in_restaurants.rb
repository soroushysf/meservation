class ChangeAddressFieldsInRestaurants < ActiveRecord::Migration[5.0]
  def change
    rename_column :restaurants, :address, :street
    add_column :restaurants, :city, :string
    add_column :restaurants, :state, :string
    add_column :restaurants, :zip, :string
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
  end
end
