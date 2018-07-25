class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :preferredName
      t.boolean :isVeteran
      t.date :birthDate
      t.boolean :isAfterCare
      t.string :shoeSize
      t.string :phone
      t.string :joppaApartmentNumber
      t.integer :numberMeals

      t.timestamps
    end
  end
end
