class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.references :customer, index: true, foreign_key: true
      t.float :debit
      t.float :credit
      t.float :bad
      t.timestamps null: false
    end
  end
end
