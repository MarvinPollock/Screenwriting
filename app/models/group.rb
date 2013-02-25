class Group < ActiveRecord::Base
  attr_accessible :num, :status, :user_ids, :id
  has_many :projects, :inverse_of => :group
  has_and_belongs_to_many :users
  
  def equals(group)
    self.id == group.id
  end
end
