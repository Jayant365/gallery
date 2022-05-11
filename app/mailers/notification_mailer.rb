class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.album_notification.subject
  #
  def album_notification(email)
    @greeting = email

    mail to: email, from: "cu.18bcs2084@gmail.com"
  end
end
