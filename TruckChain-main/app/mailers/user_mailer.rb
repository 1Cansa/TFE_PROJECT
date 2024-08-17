# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def default_password(user, password)
    @user = user
    @password = password

    mail to: user.email, subject: '[TruckChain] Mot de passe par défaut'
  end
end
