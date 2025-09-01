class CreateAuthorizedMailAccesses < ActiveRecord::Migration[6.1]
  def change
    create_table :authorized_mail_accesses do |t|
      t.references :mailbox, null: false, foreign_key: { to_table: :client_mailboxes }
      t.string :authorized_name
      t.string :relation_to_client
      t.date :date_authorized

      t.timestamps
    end
  end
end
