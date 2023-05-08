class AddPriorityToTasks < ActiveRecord::Migration[6.1]
  def up
    add_column :tasks, :priority, :integer, default: 3, null: false
  end

  def down
    remove_column :tasks, :priority, :integer, default: 3, null: false
  end
end
