class DashboardController < ApplicationController

  def index
    if !!current_user
      @user = current_user
      @tickets = @user.tickets.open
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @tickets }
      end
    end
  end

  def show
    @closed_tickets = Ticket.closed
    @overdue_tickets = current_user.tickets.overdue_tickets    
  end

  def usa
    @usa_tickets = UserTicket.usa
  end
  
end
