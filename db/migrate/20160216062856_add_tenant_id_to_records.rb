class AddTenantIdToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :tenant_id, :int
  end
end
