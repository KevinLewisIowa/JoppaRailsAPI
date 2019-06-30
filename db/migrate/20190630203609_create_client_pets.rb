class CreateClientPets < ActiveRecord::Migration[5.0]
  def change
    create_table :client_pets do |t|
      t.string :pet_type
      t.integer :quantity
      t.boolean :food_requested

      t.timestamps
    end
  end
end
