class CreateAdminAuditLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_audit_logs do |t|
      t.references :admin, null: false, foreign_key: true
      t.integer :action, null: false
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end

    add_index :admin_audit_logs, [:admin_id, :created_at]
  end
end
