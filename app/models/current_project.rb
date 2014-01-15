class CurrentProject < ActiveRecord::Base
  validate :media_choice, presence: true
end
