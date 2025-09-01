class ClientMailbox < ApplicationRecord
    belongs_to :client
    
    has_many :authorized_mail_accesses, foreign_key: :mailbox_id
end
