class CreateHeaterTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :heater_types do |t|
      t.string :type_description

      t.timestamps
    end
  end
end
