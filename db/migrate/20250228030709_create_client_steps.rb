class CreateClientSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :client_steps do |t|
      t.integer :client_id
      t.string :step_type
      t.datetime :date_completed
      t.string :notes

      t.timestamps
    end
  end
end
