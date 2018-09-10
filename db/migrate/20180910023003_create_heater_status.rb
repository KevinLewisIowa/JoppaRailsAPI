class CreateHeaterStatus < ActiveRecord::Migration[5.0]
  def change
    create_table :heater_status do |t|
      t.string :status_name

      t.timestamps
    end
  end
end
