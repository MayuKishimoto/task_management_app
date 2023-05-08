class AddIndexTasksTitle < ActiveRecord::Migration[6.1]
  def up
    add_index :tasks, :title
  end
  def down
    remove_index :tasks, :title
  end
end
