class Project < ActiveRecord::Base
  attr_accessible :name, :group_id
  belongs_to :group, :inverse_of => :projects
  has_many :pads, :inverse_of => :project
end
