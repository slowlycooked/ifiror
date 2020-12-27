class CreateFees < ActiveRecord::Migration[6.0]
  def change
    create_table :fees do |t|
      t.string :fee_name
      t.references :book, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
