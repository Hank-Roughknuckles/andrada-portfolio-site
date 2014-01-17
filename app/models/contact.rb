class Contact < ActiveRecord::Base
  #email regex here
  EmailRegex = /[a-zA-Z0-9\-_]+@\w+\.(com|net|org)/i

  validates_format_of :email, :with => EmailRegex
  before_validation :strip_whitespace

  private
  def strip_whitespace
    self.email = self.email.strip
    self.vimeo_id = self.vimeo_id.strip
  end
end
