class CreateEmployments < ActiveRecord::Migration[6.0]
  def change
    create_table :employments do |t|
      t.integer :company_id
      t.integer :tenant_id
      t.timestamps
    end
  end
end
