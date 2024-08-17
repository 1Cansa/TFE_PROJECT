# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :order
  validates_presence_of :order_id, :temperature, :lat, :lng, :quantity

  default_scope { order(created_at: :desc) }
end
