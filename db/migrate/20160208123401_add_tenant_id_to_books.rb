class AddTenantIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :tenant_id, :int
  end
end
