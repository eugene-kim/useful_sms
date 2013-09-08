class SendTextController < ApplicationController
	def send_sms

		keyword = params['keyword']
		message = Message.find_by_keyword(keyword)

		sid               = TWILIO_CONFIG['sid']
		token             = TWILIO_CONFIG['token']
		recipient         = TWILIO_CONFIG['target_number']
		twilio_number     = TWILIO_CONFIG['from']

		@twilio_client = Twilio::REST::Client.new sid, token
		@twilio_client.account.sms.messages.create(
			from: twilio_number,
			to:   recipient,
			body: message.body
		)
		redirect_to messages_path
	end
end
