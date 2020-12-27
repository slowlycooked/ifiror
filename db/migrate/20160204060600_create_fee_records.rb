class CreateFeeRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :fee_records do |t|
      t.float :credit
      t.float :debit
      t.references :fee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
