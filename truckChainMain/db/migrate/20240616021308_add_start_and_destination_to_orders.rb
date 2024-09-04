# frozen_string_literal: true

class AddStartAndDestinationToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :start, :string, default: '-11.57405909955857,27.485894797487294'
    add_column :orders, :destination, :string
  end
end
