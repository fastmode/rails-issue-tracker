class TicketSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :due_date, :created_at, :updated_at
  has_many :issues
end