class AddAgeAndNameColumnsToClientPets < ActiveRecord::Migration[6.1]
  def change
    add_column :client_pets, :name, :string
    add_column :client_pets, :age, :integer
  end
end
