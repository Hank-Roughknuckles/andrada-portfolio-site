class ContactMailer < ActionMailer::Base
  default to: User.first.email
end
