class ReceiveTextController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def receive_sms
		@message = Message.find_by_keyword(params['Body'])
		puts params['Body']
		puts params['------------------------------------------------------------------']

		sid               = ENV['SID']
		token             = ENV['TOKEN']
		recipient         = ENV['TARGET_NUMBER']
		twilio_number     = ENV['FROM']

		@twilio_client = Twilio::REST::Client.new sid, token

		if @message
			@twilio_client.account.sms.messages.create(
				from: twilio_number,
				to:   recipient,
				body: @message.body
			)
			redirect_to root_path
		else
			@twilio_client.account.sms.messages.create(
				from: twilio_number,
				to:   recipient,
				body: "We couldn't find anything matching that keyword. Sorry."
			)
			redirect_to root_path
		end
	end
end
