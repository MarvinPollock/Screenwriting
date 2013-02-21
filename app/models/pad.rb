class Pad < ActiveRecord::Base
  belongs_to :project
  has_many :frames
  attr_accessible :content, :story, :title
end
