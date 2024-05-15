class MonthlyMoneyToString < ActiveRecord::Migration[6.1]
  def change
    change_column :client_incomes, :monthly_money, :string
  end
end
