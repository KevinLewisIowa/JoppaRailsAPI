class TanksHosesNumber < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :number_tanks, :integer
    add_column :clients, :number_hoses, :integer
  end
end
