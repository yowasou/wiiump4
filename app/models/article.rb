
class Article < ActiveRecord::Base
  mount_uploader :video, AvatarUploader
  validates :title, :video, :presence => true

end
