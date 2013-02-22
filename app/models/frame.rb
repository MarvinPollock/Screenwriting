class Frame < ActiveRecord::Base
  belongs_to :pad
  attr_accessible :descr, :image, :p_name
end
