class AddCommentToFeeRecords < ActiveRecord::Migration
  def change
    add_column :fee_records, :comment, :text
  end
end
