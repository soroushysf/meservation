class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :email
      t.date :date
      t.time :time
      t.text :message
      t.integer :restaurant_id

      t.timestamps
    end
    add_index :reservations, :restaurant_id
  end
end
