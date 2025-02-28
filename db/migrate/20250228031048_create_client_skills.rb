class CreateClientSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :client_skills do |t|
      t.integer :client_id
      t.string :skill
      t.string :notes

      t.timestamps
    end
  end
end
