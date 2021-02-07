class AddCompanyIdToBookAndFee < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :tenant_id
    add_column :books, :company_id, :int
  end
end
