class Project < ActiveRecord::Base
  belongs_to :group
  has_many :pads
  has_many :frames
  attr_accessible :changed_date, :created, :group_id, :name
end
