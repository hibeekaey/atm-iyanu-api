class AddBalanceToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :balance, :decimal, default: 0.0, scale: 2, precision: 14
  end
end
