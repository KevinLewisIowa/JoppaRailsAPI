class AddAdminNotesToLocationCamps < ActiveRecord::Migration[5.0]
  def change
    add_column :location_camps, :admin_notes, :string
  end
end
