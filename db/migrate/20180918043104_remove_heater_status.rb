class RemoveHeaterStatus < ActiveRecord::Migration[5.0]
  def change
    drop_table :heater_status
  end
end
