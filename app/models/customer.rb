class Customer < ActiveRecord::Base
  validates :cname, presence: true, uniqueness: {scope: :tenant}

  has_many :records, dependent: :destroy
  belongs_to :tenant
end
