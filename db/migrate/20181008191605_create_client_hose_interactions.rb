class CreateClientHoseInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :client_hose_interactions do |t|
      t.integer :client_id
      t.integer :heater_status_id

      t.timestamps
    end
  end
end
