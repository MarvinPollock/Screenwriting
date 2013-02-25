class Pad < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :project, :inverse_of => :pads
  has_many :frames, :inverse_of => :pad
end
