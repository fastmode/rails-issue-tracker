class UserTicket < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  scope :usa, -> { where(location: 'USA') }
end
