class CreateClientCircleOfFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :client_circle_of_friends do |t|
      t.string :volunteer_name
      t.string :phone_number
      t.string :email
      t.string :notes

      t.timestamps
    end
  end
end
