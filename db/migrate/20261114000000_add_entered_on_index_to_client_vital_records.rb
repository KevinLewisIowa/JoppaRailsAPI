class AddEnteredOnIndexToClientVitalRecords < ActiveRecord::Migration[6.1]
  def change
    add_index :client_vital_records, [:entered_on, :id]
  end
end
