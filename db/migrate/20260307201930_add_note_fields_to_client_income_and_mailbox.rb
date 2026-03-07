class AddNoteFieldsToClientIncomeAndMailbox < ActiveRecord::Migration[6.1]
  def change
    add_column :client_incomes, :notes, :text
    add_column :client_mailboxes, :notes, :text
  end
end
