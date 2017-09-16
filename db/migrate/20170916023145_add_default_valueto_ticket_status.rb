class AddDefaultValuetoTicketStatus < ActiveRecord::Migration[5.1]
  def change
    change_column :tickets, :status, :string, default: "Open"
  end
end
