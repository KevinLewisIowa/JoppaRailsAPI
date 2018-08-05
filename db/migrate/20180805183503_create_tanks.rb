class CreateTanks < ActiveRecord::Migration[5.0]
  def change
    create_table :tanks do |t|
      t.string :serial_number

      t.timestamps
    end
  end
end
