class User < ActiveRecord::Base
  belongs_to :group
  ROLES = %w[student admin]
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :group_id, :identifier_url, :last_name, :name, :role
  def role?(base_role)
    if mapRole(self.role)
      ROLES.index(base_role.to_s) <= ROLES.index(mapRole(self.role))
    else
      false
    end
  end
  
  # Takes a number between 1 and 2 and return
  # the corresponding role
  def mapRole(r)
    if r == 1
      "student"
    elsif r == 2
      "admin"
    end
  end
  
  def equals(user)
    user.first_name == self.first_name && user.last_name == self.last_name && user.email == self.email && user.group_id == self.group_id
  end
  
end
