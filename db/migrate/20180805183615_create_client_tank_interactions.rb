class CreateClientTankInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :client_tank_interactions do |t|
      t.integer :client_id
      t.integer :tank_id

      t.timestamps
    end
  end
end
