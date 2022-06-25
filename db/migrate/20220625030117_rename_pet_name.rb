class RenamePetName < ActiveRecord::Migration[6.1]
  def change
    rename_column :client_pets, :name, :pet_name
  end
end
