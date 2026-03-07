class CreateClientReleaseAcknowledgements < ActiveRecord::Migration[6.1]
  def change
    create_table :client_release_acknowledgements do |t|
      t.integer :client_id
      t.datetime :date_acknowledged

      t.timestamps
    end
  end
end
