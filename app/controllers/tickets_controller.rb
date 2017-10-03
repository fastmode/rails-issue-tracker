class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?

  def new
    @ticket = Ticket.new
  end

# Need code to determine that logged in user can only see their tickets
# b = UserTicket.find_by(ticket_id: params[:id]).user_id
# current_user.id == b.user_id
# && current_usera

  def show
    # binding.pry
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
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        user_ticket = UserTicket.create(user_id: current_user.id, ticket_id: @ticket.id)
        user_ticket.save
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
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
      format.html { redirect_to root_path, notice: 'Ticket was successfully destroyed.' }
    end
  end

  private
    def set_ticket
      if @ticket = Ticket.find_by(id: params[:id])
        @ticket
      else
        redirect_to root_path
      end
    end

   def ticket_params
     params.require(:ticket).permit(
       :title,
       :status,
       :due_date
     )
   end


end
