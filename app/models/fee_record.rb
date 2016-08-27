class FeeRecord < ActiveRecord::Base
  validates :debit,  numericality: true
  validates :credit,  numericality: true

  belongs_to :fee

  ##scope :a, where('year(fee_records.updated_at) =?', Time.now.year)

  def self.sum_debit
    sum(:debit)
  end

end
