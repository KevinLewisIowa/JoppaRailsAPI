class AddDwellingToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :dwelling, :string
  end
end
