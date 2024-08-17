# frozen_string_literal: true

class CreateTrucks < ActiveRecord::Migration[7.1]
  def change
    create_table :trucks do |t|
      t.string :plate
      t.float :capacity

      t.timestamps
    end
  end
end
