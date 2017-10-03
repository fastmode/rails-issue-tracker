class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    if !user_signed_in?
      redirect_to root_path
    end
  end

  def user_owns_ticket?
    !!current_user.tickets && current_user.id == UserTicket.find_by(ticket_id: params[:id]).user_id
  end

end
