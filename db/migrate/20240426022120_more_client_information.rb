class MoreClientInformation < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :diagnosed_mental_physical_disability, :boolean
    add_column :clients, :highest_level_education, :string
    add_column :client_dwellings, :where_sleep_last_night, :string
  end
end
