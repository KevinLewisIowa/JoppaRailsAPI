class AddClientIdToCaseworker < ActiveRecord::Migration[6.1]
  def change
    add_column :client_caseworkers, :client_id, :integer
  end
end
