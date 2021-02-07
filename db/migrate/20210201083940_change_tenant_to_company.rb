class ChangeTenantToCompany < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :tenant_id
    add_column :customers, :company_id, :int
  end
end
