class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :number, :status
  validates_inclusion_of :status, in: %w(active inactive)
  enum status: { active: 'active', inactive: 'inactive' }
end
