class ReceiveTextController < ApplicationController
	def receive_sms
		@message = Message.find_by_keyword(params['Body'])
		SMSLogger.log_text_message @message.body
		end
	end
end
