class Group < ActiveRecord::Base
  has_many :users
  has_many :projects
  attr_accessible :group_id, :status
end
