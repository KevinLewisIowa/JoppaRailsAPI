class AddUniquenessForNameHeater < ActiveRecord::Migration[5.0]
  def change
    add_index :clients, [:first_name, :last_name], unique: true
  end
end
