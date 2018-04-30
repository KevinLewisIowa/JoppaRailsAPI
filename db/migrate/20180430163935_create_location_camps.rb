class CreateLocationCamps < ActiveRecord::Migration[5.0]
  def change
    create_table :location_camps do |t|
      t.string :name
      t.integer :location_id
      t.boolean :is_active

      t.timestamps
    end
  end
end
