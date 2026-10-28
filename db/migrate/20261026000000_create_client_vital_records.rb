class CreateClientVitalRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :client_vital_records do |t|
      t.references :client, null: false, foreign_key: true
      t.string :document_type, null: false
      t.text :notes
      t.date :entered_on, null: false
      t.boolean :signed_agreement, null: false, default: false
      t.date :retrieved_on

      t.timestamps
    end
  end
end