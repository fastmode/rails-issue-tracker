class DashboardController < ApplicationController

  def index
    if !!current_user
      @user = current_user
      @tickets = @user.tickets
    end
  end
  
end
