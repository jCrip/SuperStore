class UserMailer < ApplicationMailer

  def welcome_email user
    @user = user
    @url = 'www.superstore.com'

    mail(
         to: 'juancrip@gmail.com',
         subject: 'Bienvenido a SuperStore',
         template_path: 'user_mailer', #opcional si sigues la convension
         template_name: 'welcome_email' # opcional si sigues la convension
         )
  end

end
