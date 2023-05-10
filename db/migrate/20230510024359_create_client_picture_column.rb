class CreateClientPictureColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :client_picture, :bytea
  end
end
