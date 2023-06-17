class AddRaceEthnicityToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :race, :string
    add_column :clients, :ethnicity, :string
  end
end
