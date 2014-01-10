class Works < ActiveRecord::Base
  VideoLinkRegex = /[a-zA-Z:\/]+vimeo.com\/[0-9]+/i

  validates_presence_of :description, :video_link
  validates_format_of :video_link, :with => VideoLinkRegex
  before_validation :strip_whitespace

  private
  def strip_whitespace
    self.video_link = self.video_link.strip
  end
end
