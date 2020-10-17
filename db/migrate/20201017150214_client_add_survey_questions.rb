class ClientAddSurveyQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :first_time_homeless, :boolean
    add_column :clients, :date_became_homeless, :date
    add_column :clients, :homeless_reason, :string
  end
end
