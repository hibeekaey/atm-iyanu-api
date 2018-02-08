class AddAccountTypeToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :account_type, :string, default: 'savings_account'
  end
end