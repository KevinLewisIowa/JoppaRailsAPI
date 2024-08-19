class EditClientsIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :clients, name: 'index_clients_on_first_name_and_last_name'
    add_index :clients, [:first_name, :last_name, :birth_date], unique: true
  end
end
