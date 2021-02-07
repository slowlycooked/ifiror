class Customer < ActiveRecord::Base
  validates :cname, presence: true, uniqueness: {scope: :company}

  has_many :records, dependent: :destroy
  belongs_to :company

end
