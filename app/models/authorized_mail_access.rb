class AuthorizedMailAccess < ApplicationRecord
    belongs_to :mailbox, class_name: 'ClientMailbox'
end
