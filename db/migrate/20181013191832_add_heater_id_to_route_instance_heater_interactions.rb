class AddHeaterIdToRouteInstanceHeaterInteractions < ActiveRecord::Migration[5.0]
  def change
    add_column :route_instance_heater_interactions, :heater_id, :integer
  end
end
