class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :title
      t.text :description
      t.string :status
      t.datetime :due_date
      t.string :assigned_to
      t.integer :ticket_id

      t.timestamps
    end
  end
end
