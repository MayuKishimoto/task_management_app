class AddExpiredAtTasks < ActiveRecord::Migration[6.1]
  def up
    add_column :tasks, :expired_at, :datetime, default: -> { 'NOW()' }, null: false
  end

  def down
    remove_column :tasks, :expired_at, :datetime, default: -> { 'NOW()' }, null: false
  end
end
