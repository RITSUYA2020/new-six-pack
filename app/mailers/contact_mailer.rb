class ContactMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact_mail.subject
  #

  default from: 'example@example.com' # 送信元アドレス

  def send_email(contact)
    @contact = contact
    mail(to: contact.email, subject: 'お問い合わせが完了しました')
  end
end
