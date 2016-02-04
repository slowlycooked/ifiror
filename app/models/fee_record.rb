class FeeRecord < ActiveRecord::Base
  validates :debit,  numericality: true
  validates :credit,  numericality: true

  belongs_to :fee
end
