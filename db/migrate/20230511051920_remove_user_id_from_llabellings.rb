class RemoveUserIdFromLlabellings < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :labellings, :users
    remove_reference :labellings, :user, index: true
  end
end
