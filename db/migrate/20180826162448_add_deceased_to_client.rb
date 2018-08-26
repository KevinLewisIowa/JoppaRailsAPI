class AddDeceasedToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :deceased, :boolean
  end
end
