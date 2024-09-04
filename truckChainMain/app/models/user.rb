# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :trackable
  validates_presence_of :full_name, :email, length: { maximum: 25 }

  after_create :send_default_password

  default_scope { order(created_at: :desc) }
  scope :all_clients, -> { where(role: 'USER') }

  def password_required?
    return false if new_record?

    super
  end

  private

  def send_default_password
    return unless encrypted_password.blank?

    password = SecureRandom.hex(6)
    update(password:)
    UserMailer.default_password(self, password).deliver_now
  end
end
