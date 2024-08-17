# frozen_string_literal: true

module ApplicationHelper
  def admin?
    current_user && current_user.role == 'ADMIN'
  end
end
