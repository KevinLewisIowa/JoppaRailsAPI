class RemovePrimaryKeyFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :primary_key
    remove_column :users, :serial
  end
end
