class CreateClientFelonies < ActiveRecord::Migration[6.1]
  def change
    create_table :client_felonies do |t|
      t.integer :client_id
      t.string :felony_type
      t.string :year_occurred
      t.string :notes

      t.timestamps
    end
  end
end
