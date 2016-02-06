class Customer < ActiveRecord::Base
  validates :cname, presence: true, uniqueness: true

  has_many :records, dependent: :destroy
end
