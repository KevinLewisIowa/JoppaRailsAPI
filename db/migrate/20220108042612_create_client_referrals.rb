class CreateClientReferrals < ActiveRecord::Migration[6.1]
  def change
    create_table :client_referrals do |t|
      t.integer :client_id
      t.string :referral_type
      t.integer :quantity
      t.string :notes

      t.timestamps
    end
  end
end
