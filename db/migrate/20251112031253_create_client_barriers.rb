class CreateClientBarriers < ActiveRecord::Migration[6.1]
  def change
    create_table :client_barriers do |t|
      t.integer :client_id
      t.string :barrier_type
      t.string :note

      t.timestamps
    end
  end
end
