class AddBackgroundToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :hometown, :string
    add_column :clients, :city_grew_up_in, :string
    add_column :clients, :family_currently_lives_in, :string
  end
end
