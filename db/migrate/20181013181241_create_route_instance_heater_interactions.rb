class CreateRouteInstanceHeaterInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :route_instance_heater_interactions do |t|
      t.integer :route_instance_id
      t.boolean :is_checked_out

      t.timestamps
    end
  end
end
