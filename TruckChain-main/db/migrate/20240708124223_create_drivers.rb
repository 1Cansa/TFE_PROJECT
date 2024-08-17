class CreateDrivers < ActiveRecord::Migration[7.1]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :affiliation
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
