class CreateRentals < ActiveRecord::Migration[7.1]
  def change
    create_table :rentals do |t|
      t.integer :price
      t.integer :number_of_bedrooms
      t.text :amenities

      t.timestamps
    end
  end
end
