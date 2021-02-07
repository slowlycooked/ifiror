class Employment < ActiveRecord::Base
  #validates :tenant_id, uniqueness: { scope: [:company_id] }

  belongs_to :company
  belongs_to :tenant


end
