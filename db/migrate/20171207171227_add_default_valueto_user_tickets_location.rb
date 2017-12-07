class AddDefaultValuetoUserTicketsLocation < ActiveRecord::Migration[5.1]
  def change
    change_column :user_tickets, :location, :string, default: "USA"
  end
end
