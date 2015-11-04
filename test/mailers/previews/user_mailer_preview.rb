# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email_preview
    UserMailer.welcome_email(User.last)
  end

  def password_changed_preview
    UserMailer.password_changed(User.last)
  end
end
