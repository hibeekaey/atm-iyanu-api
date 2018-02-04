class User < ApplicationRecord
  has_many :accounts
  before_validation :set_status

  validates_presence_of :first_name, :surname, :middle_name, :email, :phone_number
  validates_email_format_of :email
  validates_inclusion_of :status, in: %w(active suspended)
  validates_uniqueness_of :email

  enum status: { active: 'active', suspended: 'suspended' }

  def self.attempt_registration(first_name, surname, middle_name, email, phone_number)
    user = User.new
    user.first_name= first_name
    user.middle_name= middle_name
    user.surname= surname
    user.email= email
    user.phone_number= phone_number

    if user.save
      { exec_status: true, data: user }
    else
      { exec_status: false, data: user }
    end
  end

  private
  def set_status
    if self.status.nil?
      self.status= 'active'
    end
  end
end