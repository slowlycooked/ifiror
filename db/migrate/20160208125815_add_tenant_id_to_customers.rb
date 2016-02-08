class AddTenantIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :tenant_id, :int
  end
end
