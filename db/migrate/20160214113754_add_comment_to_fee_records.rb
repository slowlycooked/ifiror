class AddCommentToFeeRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :fee_records, :comment, :text
  end
end
