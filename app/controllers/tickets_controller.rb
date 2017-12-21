class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  before_action :authenticate_user!

  def new
    @ticket = Ticket.new
    render 'new', layout: false
  end

  def index
    if !!current_user
      @user = current_user
      @tickets = @user.tickets.open
      respond_to do |format|
        format.html { render 'dashboard/index' }
        format.json { render json: @tickets, layout: false }
      end
    end
  end

  def show
    if user_owns_ticket?
      @ticket = Ticket.find(params[:id])
      @issue = Issue.new
      @issues = @ticket.issues
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @ticket, layout: false }
      end
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def create
    @ticket = Ticket.create(ticket_params)
    respond_to do |format|
      format.html { redirect_to @ticket }
      UserTicket.create(user_id: current_user.id, ticket_id: @ticket.id, location: set_location)
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
