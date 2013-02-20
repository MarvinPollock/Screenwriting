class Project < ActiveRecord::Base
  attr_accessible :changed_date, :created, :group_id, :name
end
