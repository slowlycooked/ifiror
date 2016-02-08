class Book < ActiveRecord::Base
  validates :book_name, presence: true, uniqueness: true
  has_many :fees, dependent: :destroy
  has_many :fee_records, through: :fees

  accepts_nested_attributes_for :fees
  accepts_nested_attributes_for :fee_records

  belongs_to :tenant


end