# frozen_string_literal: true

class Truck < ApplicationRecord
  belongs_to :driver

  validates_presence_of :plate, :capacity
  validates_uniqueness_of :plate, case_sensitive: false
  validates_numericality_of :capacity, greater_than: 0

  default_scope { order(created_at: :desc) }
  scope :all_available, -> { where(is_available: true) }
end
