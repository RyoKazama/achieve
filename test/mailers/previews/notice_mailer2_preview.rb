# Preview all emails at http://localhost:3000/rails/mailers/notice_mailer2
class NoticeMailer2Preview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notice_mailer2/sendmail_contact
  def sendmail_contact
    NoticeMailer2.sendmail_contact
  end

end
