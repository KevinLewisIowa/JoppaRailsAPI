class CreateRequestedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :requested_items do |t|
      t.integer :client_id
      t.string :item_description
      t.date :date_requested
      t.boolean :has_received

      t.timestamps
    end
  end
end
