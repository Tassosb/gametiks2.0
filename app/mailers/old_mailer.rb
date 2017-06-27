class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'welcome to Gametiks')
  end
end
