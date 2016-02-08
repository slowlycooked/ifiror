class Fee < ActiveRecord::Base
  validates :fee_name, presence: true, uniqueness: {scope: :book}

  belongs_to :book
  has_many :fee_records, dependent: :destroy
end
