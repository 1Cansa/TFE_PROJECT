# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.float :shipped_quantity
      t.float :received_quantity, null: true
      t.references :truck, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :shipped_at, null: true

      t.timestamps
    end
  end
end
