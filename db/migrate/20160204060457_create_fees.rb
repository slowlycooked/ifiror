class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.string :fee_name

      t.timestamps null: false
    end
  end
end
