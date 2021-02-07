class ChangeRecordsTenantToCompany < ActiveRecord::Migration[6.0]
  def change
    remove_column :records, :tenant_id
    add_column :records, :company_id, :int
  end
end
