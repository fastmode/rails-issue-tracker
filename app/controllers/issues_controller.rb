class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def new
    @issue = Issue.new
  end

  def show
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end
    
end
