class AddIsAftercareToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :is_aftercare, :boolean
  end
end
