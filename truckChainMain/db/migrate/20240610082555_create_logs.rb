# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :logs do |t|
      t.float :temperature
      t.float :quantity
      t.float :lat
      t.float :lng
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
