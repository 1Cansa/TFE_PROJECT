# frozen_string_literal: true

class Driver < ApplicationRecord
  has_many :trucks

  validates_presence_of :name, :affiliation, :email, :phone_number
end
