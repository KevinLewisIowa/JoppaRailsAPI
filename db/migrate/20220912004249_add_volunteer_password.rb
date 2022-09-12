class AddVolunteerPassword < ActiveRecord::Migration[6.1]
  def change
    add_column :pass_tokens, :volunteer_password, :string
  end
end
