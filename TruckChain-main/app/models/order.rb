# frozen_string_literal: true

class Order < ApplicationRecord
  #enum :status, { pending: 0, canceled: 1, shipped: 2 }, validated: true, suffix: true, default: :pending
  belongs_to :truck
  belongs_to :user

  validates_presence_of :truck_id, :user_id, :shipped_quantity, :shipped_at, :start, :destination
  validates_numericality_of :shipped_quantity, greater_than: 0
  # validates_numericality_of :shipped_at, less_than_or_equal_to: Time.current, allow_nil: true

  default_scope -> { order(created_at: :desc) }
  scope :shipped_for, ->(id) { where(status: 2, user_id: id) }
  scope :unshipped_for, ->(id) { where(status: 0, user_id: id).or(where(status: 1)) }
  scope :count_shipped_for, ->(id) { shipped_for(id).count }
  scope :count_unshipped_for, ->(id) { unshipped_for(id).count }
end
