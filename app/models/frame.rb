class Frame < ActiveRecord::Base
  belongs_to :pad
  belongs_to :pad, :inverse_of => :frames
  attr_accessible :descr, :image, :p_name
end
