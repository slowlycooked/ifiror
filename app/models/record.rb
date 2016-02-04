class Record < ActiveRecord::Base
  validates :debit,  numericality: true
  validates :credit,  numericality: true
  validates :bad,  numericality: true
  belongs_to :customer
end
