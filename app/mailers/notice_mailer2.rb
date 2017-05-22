class NoticeMailer2 < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer2.sendmail_contact.subject
  #
  def sendmail_contact(contact)
    @contact = contact

    mail to: "ryo.kazama1023@gmail.com",
    subject:'[Achieve]お問い合わせ完了しました'
    end
end
