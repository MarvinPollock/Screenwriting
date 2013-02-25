class Message < ActiveRecord::Base
  attr_accessible :content, :object, :receiver, :sender
end
