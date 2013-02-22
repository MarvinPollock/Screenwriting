class User < ActiveRecord::Base
  belongs_to :group
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :group_id, :identifier_url, :last_name, :name, :role
end
