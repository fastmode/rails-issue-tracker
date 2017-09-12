class TicketsController < ApplicationController

  def new
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
    @issues = @ticket.issues
  end
end
