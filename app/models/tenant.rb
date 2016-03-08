class Tenant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :timeoutable, :registerable, :recoverable

  has_many :customers
  has_many :books
end
