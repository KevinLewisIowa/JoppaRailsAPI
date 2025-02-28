class CreateClientHealthInsurances < ActiveRecord::Migration[6.1]
  def change
    create_table :client_health_insurances do |t|
      t.integer :client_id
      t.string :has_health_insurance
      t.string :company

      t.timestamps
    end
  end
end
