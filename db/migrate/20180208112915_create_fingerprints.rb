class CreateFingerprints < ActiveRecord::Migration[5.0]
  def change
    create_table :fingerprints do |t|
      t.string :fpos
      t.integer :nfig
      t.string :base64_template
      t.belongs_to :user

      t.timestamps
    end
  end
end