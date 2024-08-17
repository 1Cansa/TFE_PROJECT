# frozen_string_literal: true

class AddAvailabilityToTrucks < ActiveRecord::Migration[7.1]
  def change
    add_column :trucks, :is_available, :boolean, null: true, default: true
  end
end
