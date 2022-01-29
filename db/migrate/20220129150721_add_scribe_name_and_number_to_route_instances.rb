class AddScribeNameAndNumberToRouteInstances < ActiveRecord::Migration[6.1]
  def change
    add_column :route_instances, :scribe_name, :string
    add_column :route_instances, :scribe_phone, :string
  end
end
