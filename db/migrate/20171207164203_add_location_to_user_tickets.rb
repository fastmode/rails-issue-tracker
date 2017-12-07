class AddLocationToUserTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :user_tickets, :location, :string
  end
end
