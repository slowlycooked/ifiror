class AddCommentToRecord < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :comment, :text
  end
end
