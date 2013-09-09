class ReceiveTextController < ApplicationController
	def receive_sms
		@message = Message.find_by_keyword(params['Body'])
		if @message
			@message.body
		else
			render 'sample_message', :content_type => 'text/xml'
		end
	end
end
