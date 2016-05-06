class Tenant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :timeoutable, :registerable,
         :authentication_keys => [:login]

  attr_accessor :login

  validates :mobile,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }

  validates :invitation,
            presence: true,
            inclusion: { in: ["weierkang"] }

  # Only allow letter, number, underscore and punctuation.
  validates_format_of :mobile, with: /^[0-9\.]*$/, :multiline => true

  has_many :customers
  has_many :books

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.mobile || self.email
  end

  #https://github.com/plataformatec/devise/wiki/How-To%3A-Allow-users-to-sign-in-using-their-username-or-email-address

  def self.find_for_database_authentication(warden_conditions)
    #conditions = warden_conditions.dup
    #if mobile = conditions.delete(:mobile)
    #  where(conditions.to_h).where(["mobile = :value", { :value => mobile.downcase }]).first
    #elsif conditions.has_key?(:mobile)
    #  where(conditions.to_h).first
    #end
    #binding.pry


    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["mobile = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:mobile) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end



  end


end
