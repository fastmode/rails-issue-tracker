class Ticket < ApplicationRecord
  has_many :user_tickets
  has_many :issues
end
