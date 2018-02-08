class User < ApplicationRecord
  has_many :accounts
  has_many :fingerprints
  before_validation :set_status

  validates_presence_of :first_name, :surname, :middle_name, :email, :phone_number
  validates_email_format_of :email
  validates_inclusion_of :status, in: %w(active suspended)
  validates_uniqueness_of :email

  enum status: { active: 'active', suspended: 'suspended' }

  def self.attempt_registration(signatory_details, fingerprint_data)
    ActiveRecord::Base.transaction do
      user = User.new
      user.first_name= signatory_details[:first_name]
      user.middle_name= signatory_details[:middle_name]
      user.surname= signatory_details[:surname]
      user.email= signatory_details[:email]
      user.phone_number= signatory_details[:phone_number]

      if user.save!
        fingerprint = Fingerprint.new
        fingerprint.fpos= fingerprint_data[:fpos]
        fingerprint.nfig= fingerprint_data[:nfig]
        fingerprint.base64_template= fingerprint_data[:base64_template]
        fingerprint.user= user

        if fingerprint.save!
          res = Account.attempt_creation(user.id,
                                         "#{user.first_name} #{user.surname}",
                                         nil,
                                         500000)

          { exec_status: true, data: {
              user: user,
              account: res[:data],
              fingerprint: fingerprint
          }}
        else
          { exec_status: false, data: nil }
        end
      else
        { exec_status: false, data: nil }
      end
    end
  end

  private
  def set_status
    if self.status.nil?
      self.status= 'active'
    end
  end
end