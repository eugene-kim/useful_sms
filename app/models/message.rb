class Message < ActiveRecord::Base
  attr_accessible :body, :description, :keyword
end
