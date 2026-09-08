class CreateAdminTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_tokens do |t|
      t.references :admin, null: false, foreign_key: true
      t.string :token, null: false
      t.datetime :expires_at, null: false

      t.timestamps
    end

    add_index :admin_tokens, :token, unique: true
    add_index :admin_tokens, :expires_at
  end
end
