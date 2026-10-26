class CreateClientDisabilityAndDisorders < ActiveRecord::Migration[6.1]
  def change
    create_table :client_disability_and_disorders do |t|
      t.integer :client_id, null: false
      t.string :category, null: false
      t.string :diagnosis_status
      t.string :type_name
      t.integer :year_diagnosed
      t.string :clinically_diagnosed
      t.text :note

      t.timestamps
    end

    add_index :client_disability_and_disorders, :client_id
    add_index :client_disability_and_disorders, :category
  end
end
