class Fee < ActiveRecord::Base
  validates :fee_name, presence: true, uniqueness: true

  belongs_to :book
  has_many :fee_records, dependent: :destroy
end
