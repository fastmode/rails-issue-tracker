class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  before_action :authenticate_user!

  def new
    @ticket = Ticket.new
  end

  def show
    if user_owns_ticket?
      @ticket = Ticket.find(params[:id])
      @issues = @ticket.issues
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket }
        UserTicket.create(user_id: current_user.id, ticket_id: @ticket.id, location: set_location)
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        @user_ticket.update(location: set_location)
        format.html { redirect_to @ticket }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if !@ticket.issues.empty? 
      @ticket.issues do |issue|
        issue.destroy
      end
    end
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to root_path}
    end
  end

  private
  
  def set_ticket
    if @ticket = Ticket.find_by(id: params[:id])
      @ticket
      @user_ticket = UserTicket.find_by(ticket_id: @ticket.id)
    else
      redirect_to root_path
    end
  end

  def ticket_params
    params.require(:ticket).permit(
      :title,
      :status,
      :due_date,
      issues_attributes: [
        :title,
        :description]
    )
  end

  def set_location
    params["ticket"]["user_tickets"]["location"]
  end
  
end
