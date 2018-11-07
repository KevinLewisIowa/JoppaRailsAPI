class CreatePassTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :pass_tokens do |t|
      t.string :admin_password
      t.string :string
      t.string :regular_password
      t.string :string
      t.string :api_token
      t.string :string

      t.timestamps
    end
  end
end
