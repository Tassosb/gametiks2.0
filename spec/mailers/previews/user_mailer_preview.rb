# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def sample_mail_preview
    UserMailer.sample_email(User.first)
  end

  def account_activation_preview
    UserMailer.account_activation(User.first)
  end

  def welcome_email_preview
    UserMailer.welcome_email(User.first)
  end
  
end
