class ChangeYearDiagnosedToStringOnClientDisabilityAndDisorders < ActiveRecord::Migration[6.1]
  def up
    change_column :client_disability_and_disorders, :year_diagnosed, :string, using: 'year_diagnosed::varchar'
  end

  def down
    execute "UPDATE client_disability_and_disorders SET year_diagnosed = NULL WHERE year_diagnosed = 'Unknown'"
    change_column :client_disability_and_disorders, :year_diagnosed, :integer, using: 'year_diagnosed::integer'
  end
end
