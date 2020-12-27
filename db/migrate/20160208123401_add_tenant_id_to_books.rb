class AddTenantIdToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :tenant_id, :int
  end
end
