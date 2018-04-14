class CreateCampingEquipments < ActiveRecord::Migration[5.0]
  def change
    create_table :camping_equipments do |t|
      t.string :name
      t.boolean :is_available
      t.string :joppa_number

      t.timestamps
    end
  end
end
