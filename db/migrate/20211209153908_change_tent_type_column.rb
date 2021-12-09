class ChangeTentTypeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :client_tents, :type, :tent_type
  end
end
