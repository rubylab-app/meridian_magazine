class CreateIronAdminAuditEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :iron_admin_audit_entries do |t|
      t.string :user_identifier
      t.string :action, null: false
      t.string :resource, null: false
      t.integer :record_id
      t.text :record_changes
      t.string :ip_address
      t.timestamps

      t.index :resource
      t.index :action
      t.index :created_at
    end
  end
end
