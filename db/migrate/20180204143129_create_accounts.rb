class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :number
      t.string :status
      t.belongs_to :user

      t.timestamps
    end
  end
end