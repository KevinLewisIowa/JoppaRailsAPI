class AddLocationHistoryQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :city_state_before_homelessness, :string
    add_column :clients, :what_brought_to_des_moines, :string
  end
end
