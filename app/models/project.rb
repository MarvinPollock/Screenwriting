class Project < ActiveRecord::Base
  attr_accessible :changed, :created, :group_id, :name
end
