class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :surname
      t.string :middle_name
      t.string :email
      t.string :phone_number
      t.string :status

      t.timestamps
    end
  end
end
