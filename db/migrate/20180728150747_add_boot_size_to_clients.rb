class AddBootSizeToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :boot_size, :string
  end
end
