class User < ActiveRecord::Base
  attr_accessible :email, :encrypted_password, :group_id, :role, :salt, :username
end
