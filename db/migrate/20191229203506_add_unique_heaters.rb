class AddUniqueHeaters < ActiveRecord::Migration[5.0]
  def change
    add_index :heaters, :serial_number, unique: true
  end
end
