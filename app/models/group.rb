class Group < ActiveRecord::Base
  has_many :users
  has_many :projects
  attr_accessible :group_id, :status
  
  def contains(user)
    present = false
    users.each{ |i|
      present = user.equals(i)
    }
    present
  end
end
