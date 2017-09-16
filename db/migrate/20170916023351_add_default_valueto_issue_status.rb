class AddDefaultValuetoIssueStatus < ActiveRecord::Migration[5.1]
  def change
    change_column :issues, :status, :string, default: "Open"
  end
end
