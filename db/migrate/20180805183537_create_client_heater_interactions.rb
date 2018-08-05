class CreateClientHeaterInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :client_heater_interactions do |t|
      t.integer :client_id
      t.integer :heater_id

      t.timestamps
    end
  end
end
