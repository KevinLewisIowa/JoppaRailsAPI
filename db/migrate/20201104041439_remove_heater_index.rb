class RemoveHeaterIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :heaters, name: "index_heaters_on_serial_number"
  end
end
