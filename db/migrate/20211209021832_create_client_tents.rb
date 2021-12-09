class CreateClientTents < ActiveRecord::Migration[6.1]
  def change
    create_table :client_tents do |t|
      t.integer :client_id
      t.string :type
      t.string :condition
      t.datetime :date_given
      t.string :given_by
      t.string :setup_by
      t.string :notes
      t.boolean :rejected

      t.timestamps
    end
  end
end
