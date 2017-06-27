class UserMailer < ApplicationMailer
  default from: 'noreply@gametiks.com'

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end

  def account_activation(user)
    @user = user
    mail(to: @user.email, subject: 'Account Activation')
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'welcome to Gametiks')
  end
  
end
