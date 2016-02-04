class Fee < ActiveRecord::Base
  validates :fee_name, presence: true

  has_many :fee_records, dependent: :destroy
end
