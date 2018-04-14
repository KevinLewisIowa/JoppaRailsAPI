class CreateGoalsAndNextSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :goals_and_next_steps do |t|
      t.integer :client_id
      t.string :description
      t.boolean :is_completed

      t.timestamps
    end
  end
end
