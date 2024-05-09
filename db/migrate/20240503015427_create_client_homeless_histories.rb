class CreateClientHomelessHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :client_homeless_histories do |t|
      t.integer :client_id
      t.boolean :first_time_homeless
      t.date :date_became_homeless
      t.string :reason_for_homelessness
      t.string :note

      t.timestamps
    end
  end
end
