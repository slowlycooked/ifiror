class Customer < ActiveRecord::Base
  validates :cname, presence: true

  has_many :records, dependent: :destroy
end
