class OrderMailer < ApplicationMailer

  def confirmation_email(order, user)
    @user = user
    @order = order

    mail(
         to: 'juancrip@gmail.com',
         subject: 'Compra realizada'
         )
  end

  def confirmation_admin(order)
    @order = order

    mail(
         to: 'juancrip@gmail.com',
         subject: 'Se ha reliazado una compra'
        )
  end

end
