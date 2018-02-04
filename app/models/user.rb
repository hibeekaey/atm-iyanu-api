class User < ApplicationRecord
  has_many :accounts

  validates_presence_of :first_name, :surname, :middle_name, :phone_number, :email
  validates_email_format_of :email
  validates_inclusion_of :status, in: %w(active suspended)

  enum status: { active: 'active', suspended: 'suspended' }
end
