# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def confirmation_email_preview
    OrderMailer.confirmation_email(Order.last, User.last)
  end

  def confirmation_admin_preview
    OrderMailer.confirmation_admin(Order.last)
  end
end
