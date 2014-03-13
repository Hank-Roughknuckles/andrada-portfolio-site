class ContactMailer < ActionMailer::Base
  default to: User.first.email

  def contact_email(email, body)
    @email = email
    @body = body

    mail(from: email, subject: "Message from your portfolio site")
  end
end
