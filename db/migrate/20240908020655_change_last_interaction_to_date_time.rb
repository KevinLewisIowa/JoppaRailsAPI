class ChangeLastInteractionToDateTime < ActiveRecord::Migration[6.1]
  def change
    change_column :clients, :last_interaction_date, :datetime
  end
end
