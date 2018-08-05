class ChangeRouteCityToRegion < ActiveRecord::Migration[5.0]
  def change
    rename_column :routes, :city, :region
  end
end
