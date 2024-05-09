class CreateClientNextOfKins < ActiveRecord::Migration[6.1]
  def change
    create_table :client_next_of_kins do |t|
      t.integer :client_id
      t.string :name
      t.string :relation_to_client
      t.string :phone_number
      t.string :street_address
      t.string :email
      t.string :note

      t.timestamps
    end
  end
end
