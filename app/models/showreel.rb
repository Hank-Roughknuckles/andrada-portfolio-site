class Showreel < ActiveRecord::Base
  VideoLinkRegex = /[a-zA-Z:\/]*(vimeo|youtube)\.com\/.+/i

  validates_presence_of :media_choice
  validates_format_of :media_link, :with => VideoLinkRegex
  before_validation :strip_whitespace

  private
  def strip_whitespace
    self.media_link = self.media_link.strip
  end
end
