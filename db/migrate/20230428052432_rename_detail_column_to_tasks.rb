class RenameDetailColumnToTasks < ActiveRecord::Migration[6.1]
  def change
    rename_column :tasks, :detail, :content
  end
end
