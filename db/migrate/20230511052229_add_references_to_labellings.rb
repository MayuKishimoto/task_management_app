class AddReferencesToLabellings < ActiveRecord::Migration[6.1]
  def change
    add_reference :labellings, :label, null: false, foreign_key: true
  end
end
