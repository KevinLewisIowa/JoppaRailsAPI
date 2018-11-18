class CreateRouteInstanceTankHoseInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :route_instance_tank_hose_interactions do |t|
      t.integer :route_instance_id
      t.integer :number_hoses_out
      t.integer :number_hoses_in
      t.integer :number_tanks_out
      t.integer :number_tanks_in

      t.timestamps
    end
  end
end
