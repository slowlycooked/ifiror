class Book < ActiveRecord::Base
  validates :book_name, presence: true, uniqueness: true
  has_many :fees, dependent: :destroy
  has_many :fee_records, through: :fees

  accepts_nested_attributes_for :fees
  accepts_nested_attributes_for :fee_records

  belongs_to :tenant



  def self.get_monthly_sum(book_id, year)

    records = Book.find(book_id).fee_records.where('year(fee_records.updated_at) =?', year)

    records.select(' month(fee_records.updated_at) as month,
                             sum(fee_records.debit) as debit, sum(fee_records.credit) as credit')
                         .group('month(fee_records.updated_at)')
                         .order('month(fee_records.updated_at) ASC')

    #Fee.group(:fee_name).where('year(updated_at) =?',"2016").includes(:fee_records).each
    # .sum {|a| a.fee_records}.map {|a| a.debit}
  end


end