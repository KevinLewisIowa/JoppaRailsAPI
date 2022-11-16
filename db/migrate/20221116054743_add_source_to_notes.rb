class AddSourceToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :client_notes, :source, :string
  end
end
