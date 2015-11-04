class UserMailer < ApplicationMailer

  def welcome_email user
    @user = user
    @url = 'www.superstore.com'

    mail(
      to: 'juancrip@gmail.com',
      subject: 'Bienvenido a SuperStore',
      template_path: 'user_mailer', #opcional si sigues la convension de nombres
      template_name: 'welcome_email' # opcional si sigues la convension de nombres
    )
  end

  def password_changed user
    @user = user

    mail(
      to: 'juancrip@gmail.com',
      subject: 'Se ha modificado tu contraseña',
    )
  end

end
