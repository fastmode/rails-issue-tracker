class Ticket < ApplicationRecord
  has_many :user_tickets
  has_many :issues
  validates :title, presence: true

  scope :closed, -> { where(status: 'Closed') }

  def self.overdue_tickets
    where("due_date < ? AND status = ?", Date.today, "Open")
  end

  # Old reporting but written in the controller previously
  # @overdue_tickets = current_user.tickets.where("due_date < ? AND status = ?", Date.today, "Open")
  # scope :overdue_tickets, -> { where(:due_date < Date.today).and(status: 'Open') }

end
