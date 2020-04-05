class AddHouseholdsToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :household_id, :integer
  end
end
