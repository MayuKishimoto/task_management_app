class AddStatusTasks < ActiveRecord::Migration[6.1]
  def up
    add_column :tasks, :status, :string, default: '未着手', null: false
  end

  def down
    remove_column :tasks, :status, :string, default: '未着手', null: false
  end
end
