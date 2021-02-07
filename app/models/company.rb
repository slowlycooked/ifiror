class Company < ActiveRecord::Base
  has_many :employments
  has_many :customers
  has_many :tenants, through: :employments
end