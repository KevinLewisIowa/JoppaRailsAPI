class ChangeDateMovedDataType < ActiveRecord::Migration[6.1]
  def change
    change_column :client_dwellings, :date_moved, :date
  end
end
