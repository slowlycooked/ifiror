class AddRoleToTenants < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :role, :string
  end
end
