class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  before_action :set_ticket_id
  before_action :logged_in?
  before_action :authenticate_user!

  def new
    @issue = Issue.new
  end

  def show
  end 

  def edit
  end

  def create
    @issue = Issue.create(issue_params)
    @issue.ticket_id = @ticket.id
    if @issue.save
      render json: @issue, status: 201
    else
      format.html { render :new }
    end
  end

  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to [@ticket, @issue], notice: 'Issue was successfully updated.' }
      else
        format.html { render :edit }
      end 
    end
  end

  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to @ticket, notice: 'Issue was successfully destroyed.' }
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def set_ticket_id
    @ticket = Ticket.find(params[:ticket_id])
  end

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
