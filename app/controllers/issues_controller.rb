class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = Ticket.find(params[:ticket_id])
    @issue = Issue.new
  end

  def show
    @ticket = Ticket.find(params[:ticket_id])
  end 

  def edit
    @ticket = Ticket.find(params[:ticket_id])
  end

  def create
    @issue = Issue.new(issue_params)
    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

    def set_issue
      @issue = Issue.find(params[:id])
    end

    # def set_ticket
    #   binding.pry
    #   @ticket = Ticket.find(params[:ticket_id])
    # end

    def issue_params
      params.require(:issue).permit(
        :title,
        :description,
        :status,
        :due_date,
        :assigned_to
      )
    end
    
end
