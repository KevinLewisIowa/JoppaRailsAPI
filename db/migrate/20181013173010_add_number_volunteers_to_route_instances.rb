class AddNumberVolunteersToRouteInstances < ActiveRecord::Migration[5.0]
  def change
    add_column :route_instances, :number_route_members, :integer
  end
end
