class AddDateMovedToDwellings < ActiveRecord::Migration[6.1]
  def change
    add_column :client_dwellings, :date_moved, :datetime
  end
end
