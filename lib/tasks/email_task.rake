desc 'send email'
task send_email: :environment do
  order = Order.last
  user = User.first
  OrderMailer.confirmation_email(order, user).deliver_now
end