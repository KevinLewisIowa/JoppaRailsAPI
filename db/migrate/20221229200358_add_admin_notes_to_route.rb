class AddAdminNotesToRoute < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :admin_notes, :string
  end
end
