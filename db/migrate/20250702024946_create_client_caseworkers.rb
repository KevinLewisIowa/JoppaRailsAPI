class CreateClientCaseworkers < ActiveRecord::Migration[6.1]
  def change
    create_table :client_caseworkers do |t|
      t.string :organization
      t.string :name
      t.string :phone
      t.string :email
      t.string :notes

      t.timestamps
    end
  end
end
