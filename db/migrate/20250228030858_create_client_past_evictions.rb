class CreateClientPastEvictions < ActiveRecord::Migration[6.1]
  def change
    create_table :client_past_evictions do |t|
      t.integer :client_id
      t.string :eviction_type
      t.string :year_occurred
      t.string :notes

      t.timestamps
    end
  end
end
