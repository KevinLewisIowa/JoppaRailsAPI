class CreateLocationCampNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :location_camp_notes do |t|
      t.integer :location_camp_id
      t.string :note

      t.timestamps
    end
  end
end
