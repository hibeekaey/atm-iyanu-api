class Account < ApplicationRecord
  belongs_to :user
  before_validation :set_status

  validates_presence_of :name, :number, :status
  validates_inclusion_of :status, in: %w(active inactive)
  validates_numericality_of :balance
  validates_uniqueness_of :number

  enum status: { active: 'active', inactive: 'inactive' }

  def self.attempt_creation(user_id, account_name, status = nil, balance = 0)
    user = User.find(user_id)

    account = Account.new
    account.user= user
    account.name= account_name
    account.number= rand.to_s[2..11]
    account.status = status
    account.balance= balance

    if account.save
      { exec_status: true, data: account }
    else
      { exec_status: false, data: nil }
    end
  end

  def self.credit_account(account_number, amount)
    account = Account.find_by_number(account_number)

    if !account.nil?
      account.balance += amount

      if account.save
        return { exec_status: 'credit_success', data: account }
      else
        return { exec_status: 'credit_failed', data: 'Unable to update account at the moment' }
      end
    else
      { exec_status: 'invalid_account_number', data: 'Invalid account number' }
    end
  end

  def self.withdraw_amount(account_id, amount)
    account = Account.find(account_id)

    if account
      if amount >= 0 && account.balance > amount
        account.balance -= amount

        if account.save
          return { exec_status: 'withdraw_success', data: account }
        else
          return { exec_status: 'withdraw_failure', data: 'Unable to withdraw funds at the moment' }
        end
      else
        return { exec_status: 'insufficient_funds',
                 data: "Unable to withdraw #{amount} from account with id #{account_id}" }
      end
    else
      return { exec_status: 'invalid_account_id', data: 'Invalid account id' }
    end
  end

  private
  def set_status
    if self.status.nil?
      self.status= 'active'
    end
  end
end
