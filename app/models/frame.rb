class Frame < ActiveRecord::Base
  attr_accessible :descr, :image, :name
  belongs_to :pad, :inverse_of => :frames
end
