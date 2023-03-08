class AddPetBreed < ActiveRecord::Migration[6.1]
  def change
    add_column :client_pets, :breed, :string
  end
end
