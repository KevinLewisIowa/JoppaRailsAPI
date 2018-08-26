class AddInActiveToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :inactive, :boolean
  end
end
