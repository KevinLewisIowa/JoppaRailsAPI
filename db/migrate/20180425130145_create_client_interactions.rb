class CreateClientInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :client_interactions do |t|
      t.integer :client_id
      t.integer :location_id
      t.boolean :serviced

      t.timestamps
    end
  end
end
