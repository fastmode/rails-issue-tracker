class DashboardController < ApplicationController

  def index
    if !!current_user
      @user = current_user
      @tickets = @user.tickets.open
    end
  end

  def show
    @closed_tickets = Ticket.closed
    @overdue_tickets = current_user.tickets.overdue_tickets    
  end
  
end
