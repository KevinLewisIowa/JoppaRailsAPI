class AddClientIdToPets < ActiveRecord::Migration[5.0]
  def change
    add_column :client_pets, :client_id, :integer
  end
end
