class CreateCampingEquipmentGivenDates < ActiveRecord::Migration[5.0]
  def change
    create_table :camping_equipment_given_dates do |t|
      t.integer :client_id
      t.integer :camping_equipment_id
      t.date :date_given
      t.boolean :has_returned

      t.timestamps
    end
  end
end
