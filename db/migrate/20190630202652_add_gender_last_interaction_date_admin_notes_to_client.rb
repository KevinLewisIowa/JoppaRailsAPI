class AddGenderLastInteractionDateAdminNotesToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :gender, :string
    add_column :clients, :last_interaction_date, :date
    add_column :clients, :admin_notes, :string
  end
end
