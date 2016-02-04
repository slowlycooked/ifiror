class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :customer, index: true, foreign_key: true
      t.integer :book_id
      t.float :debit
      t.float :credit
      t.float :bad
      t.timestamps null: false
    end
  end
end
