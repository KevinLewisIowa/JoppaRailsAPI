class CreateClientNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :client_notes do |t|
      t.integer :route_instance_id
      t.integer :client_id
      t.string :note

      t.timestamps
    end
  end
end
