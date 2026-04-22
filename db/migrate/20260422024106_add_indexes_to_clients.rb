class AddIndexesToClients < ActiveRecord::Migration[6.1]
  def change
    add_index :clients, :status
    add_index :clients, :last_interaction_date
  end
end
