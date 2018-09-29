class AddCurrentClientIdToHeaters < ActiveRecord::Migration[5.0]
  def change
    add_column :heaters, :current_client_id, :integer
  end
end
