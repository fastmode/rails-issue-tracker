class DashboardController < ApplicationController

  def index
    if !!current_user
      @user = current_user
      @tickets = @user.tickets.where("status = ?", "Open")
    end
  end

  def show
    @closed_tickets = current_user.tickets.where("status = ?", "Closed")
    @overdue_tickets = current_user.tickets.where("due_date < ? AND status = ?", Date.today, "Open")
  end
  
end
