class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :role, default: 0, null: false
      t.string :first_name
      t.string :last_name
      t.boolean :requires_password_change, default: true
      t.datetime :last_login_at
      t.string :last_login_ip
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :admins, :email, unique: true
  end
end
