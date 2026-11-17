class CreateClientRentDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :client_rent_details do |t|
      t.references :client, null: false, foreign_key: true, index: { unique: true }
      t.decimal :rent_cost, precision: 10, scale: 2, null: false
      t.boolean :utilities_included, null: false, default: true
      t.decimal :utilities_cost, precision: 10, scale: 2
      t.string :who_is_paying, null: false
      t.text :note

      t.timestamps
    end
  end
end
