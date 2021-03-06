class Ticket < ApplicationRecord
  has_many :user_tickets
  has_many :issues
  validates :title, presence: true

  def issues_attributes=(issues_attributes)
    issues_attributes.values.each do |issue_attribute|
      @issue = Issue.create(issue_attribute)
      self.issues << @issue
    end
  end

  scope :open, -> { where(status: 'Open') }
  scope :closed, -> { where(status: 'Closed') }
  scope :overdue_tickets, -> { where("due_date < ? AND status = ?", Date.today, "Open") }

end
