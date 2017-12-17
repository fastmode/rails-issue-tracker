class IssueSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :due_date, :assigned_to, :ticket_id, :created_at, :updated_at
  belongs_to :ticket
end