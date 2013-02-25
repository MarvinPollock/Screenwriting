class Pad < ActiveRecord::Base
  attr_accessible :content, :title, :story, :p_name, :pad_url
  belongs_to :project, :inverse_of => :pads
  has_many :frames, :inverse_of => :pad
end
