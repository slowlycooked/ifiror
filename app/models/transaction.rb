class Transaction < ActiveRecord::Base
 # validates :credit,  numericality: true
 # validates :debit,  numericality: true
  #validates :bad,  numericality: true

  belongs_to :customer
end
