class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :route_id
      t.string :name
      t.integer :position
      t.string :notes
      t.decimal :longitude
      t.decimal :latitude
      t.boolean :is_active

      t.timestamps
    end
  end
end
