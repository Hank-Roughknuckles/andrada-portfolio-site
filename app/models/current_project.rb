class CurrentProject < ActiveRecord::Base
  validate :media_choice, presence: true
  has_attached_file :media_image
end
