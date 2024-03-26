class CreateLands < ActiveRecord::Migration[7.1]
  def change
    create_table :lands do |t|
      t.string :price
      t.decimal :land_area

      t.timestamps
    end
  end
end
