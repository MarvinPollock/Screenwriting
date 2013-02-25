class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :role, :group_ids, :identifier_url
  has_and_belongs_to_many :groups
  ROLES = %w[student admin]

  def role?(role)
    ROLES.index(role) <= ROLES.index(self.role)
  end
 
  def equals(user)
    user.first_name == self.first_name && user.last_name == self.last_name && user.email == self.email
  end

end
