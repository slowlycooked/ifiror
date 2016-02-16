class AddTenantIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :tenant_id, :int
  end
end
