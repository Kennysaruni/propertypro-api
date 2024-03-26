class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :location
      t.decimal :size

      t.timestamps
    end
  end
end
