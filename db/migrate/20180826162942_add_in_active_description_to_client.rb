class AddInActiveDescriptionToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :inactive_description, :string
  end
end
