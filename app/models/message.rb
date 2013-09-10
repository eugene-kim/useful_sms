class Message < ActiveRecord::Base
	before_save { |message| message.keyword = message.keyword.downcase }

  attr_accessible :body, :description, :keyword
end
