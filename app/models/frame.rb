class Frame < ActiveRecord::Base
  belongs_to :pad, :inverse_of => :frames
  attr_accessible :descr, :image, :pad_id, :name
  mount_uploader :image, AvatarUploader
end
