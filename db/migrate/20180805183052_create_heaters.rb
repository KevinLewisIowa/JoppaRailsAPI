class CreateHeaters < ActiveRecord::Migration[5.0]
  def change
    create_table :heaters do |t|
      t.integer :heater_type_id
      t.string :serial_number

      t.timestamps
    end
  end
end
