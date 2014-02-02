class Work < ActiveRecord::Base
  VideoLinkRegex = /[a-zA-Z:\/]*(vimeo|youtube)\.com\/.+/i

  validates_presence_of :media_choice
  validates_format_of :media_link, :with => VideoLinkRegex
  before_validation :strip_whitespace
  has_attached_file :media_image
  has_attached_file :grid_tile_image, :styles => { :large => "500x500>" }

  private
  def strip_whitespace
    self.media_link = self.media_link.strip
  end
end
