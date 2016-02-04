class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :cname, null:false
      t.string :phone_no
      t.timestamps null: false
    end
  end
end
