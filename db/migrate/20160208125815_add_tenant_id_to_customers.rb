class AddTenantIdToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :tenant_id, :int
  end
end
