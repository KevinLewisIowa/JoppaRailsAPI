class CreateClientDebts < ActiveRecord::Migration[6.1]
  def change
    create_table :client_debts do |t|
      t.integer :client_id
      t.string :debt_type
      t.string :amount
      t.string :notes

      t.timestamps
    end
  end
end
