class CreateClientMailboxes < ActiveRecord::Migration[6.1]
  def change
    create_table :client_mailboxes do |t|
      t.references :client, null: false, foreign_key: true
      t.string :mailbox_number
      t.string :verification_type

      t.timestamps
    end
  end
end
