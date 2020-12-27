class AddQuantityPriceToFeeRecord < ActiveRecord::Migration[6.0]
  def change
    add_column :fee_records, :quantity, :float, :default => 0.0
    add_column :fee_records, :price, :float, :default => 0.0
  end
end
