class AddDueToCovidToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :due_to_covid, :boolean
  end
end
