class AddFieldsToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :name, :string
    add_column :tenants, :mobile, :string, :limits => 11, :null => false
    add_column :tenants, :invitation, :string
  end
end
