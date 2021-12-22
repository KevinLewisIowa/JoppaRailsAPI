class AddServicedDateToClientInteractions < ActiveRecord::Migration[6.1]
  def change
    add_column :client_interactions, :serviced_date, :datetime
  end
end
