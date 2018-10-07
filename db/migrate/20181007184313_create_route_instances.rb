class CreateRouteInstances < ActiveRecord::Migration[5.0]
  def change
    create_table :route_instances do |t|
      t.integer :route_id
      t.string :leader_name
      t.string :leader_phone
      t.boolean :heat_route
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
