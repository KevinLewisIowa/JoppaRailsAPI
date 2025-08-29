class AddHealthInsuranceNote < ActiveRecord::Migration[6.1]
  def change
    add_column :client_health_insurances, :note, :string
  end
end
