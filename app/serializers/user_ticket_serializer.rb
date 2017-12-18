class UserTicketSerializer < ActiveModel::Serializer
  attributes :location
  belongs_to :ticket
end
