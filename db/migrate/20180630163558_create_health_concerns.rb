class CreateHealthConcerns < ActiveRecord::Migration[5.0]
  def change
    create_table :health_concerns do |t|
      t.integer :client_id
      t.string :description

      t.timestamps
    end
  end
end
