class AddMiddleNameToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :middle_name, :string
    remove_index :clients, name: "index_clients_on_first_name_and_last_name_and_birth_date"
    add_index :clients, [:first_name, :middle_name, :last_name, :birth_date], name:"first_middle_last_birthday_index"
  end
end
