class AddAdditionalHeaterProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :heaters, :heater_status_id, :integer
    add_column :heaters, :status_reason, :string
    add_column :heaters, :is_active, :boolean
  end
end
