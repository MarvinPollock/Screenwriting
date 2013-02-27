class Frame < ActiveRecord::Base
  belongs_to :pad
  belongs_to :pad, :inverse_of => :frames
  attr_accessible :descr, :image
  mount_uploader :image, AvatarUploader
end
