class CreateClientIncomes < ActiveRecord::Migration[6.1]
  def change
    create_table :client_incomes do |t|
      t.integer :client_id
      t.boolean :has_income
      t.integer :monthly_money
      t.string :what_income_from

      t.timestamps
    end
  end
end
