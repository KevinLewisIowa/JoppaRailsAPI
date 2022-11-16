class CreateClientDwellings < ActiveRecord::Migration[6.1]
  def change
    create_table :client_dwellings do |t|
      t.integer :client_id
      t.date :date_became_homeless
      t.string :dwelling
      t.string :notes
      t.string :homeless_reason
      t.boolean :first_time_homeless

      t.timestamps
    end
  end
end
