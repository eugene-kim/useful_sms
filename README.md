Useful SMS

Useful SMS is useful (heh) application for quickly retrieving bits of information that matter to you when you need them. This includes: Library hours, Airbears2 Keys, phone numbers, birthdays, BART schedules, etc. Instead of repeatedly searching through your emails or the web for obscure bits information that you find yourself needing a lot more than you think you do, add it as a Useful SMS message with a keyword that you make yourself

Setup Information
Useful SMS uses Twilio to send and receive text messages. If you haven't made an account with Twilio, click [here](https://www.twilio.com/) to do so to get your own Twilio number and whitelist your cellphone number (this is required on all trial accounts).

I've made it so that Twilio account sensitive values are loaded in the application through local environment variables. This way I can have a public repository for the application without exposing my account sensitive information. There are a number of ways to set your environment variables up. I've used the [figaro gem](https://github.com/laserlemon/figaro) to make things easier. The variables SID, TOKEN, TARGET_NUMBER, and FROM should be setup in config/application.yml (the figaro github page explains everything).

At this point you can create Useful SMS messages on Useful SMS and click on "Send" in the Dashboard while in your browser. Sometimes it's nice to have information easiliy accessible on your phone whenever you leave your computer. However, what we really want to do is be able to query for information from our phones to Useful SMS and have it respond back. This requires that the endpoint of the application be reachable by Twilio. I've chosen to deploy on heroku. To connect your twilio account to Useful SMS, go to https://www.twilio.com/user/account and click "Configure your trial number" (assuming you have a trial account). Under "Messaging", set the messaging request url to /receive_sms and make sure that it is set as a POST request.

Deploying on heroku means that you must set environmental variables for the deployed application. Instructions on how to do that can be found [here](https://devcenter.heroku.com/articles/config-vars). Just setup the same environment variables as you did for the local copy and you should be good to go.

Extra
If you'd like to use Useful SMS for something dynamic like scraping the web for content that changes regularly, you'll have to set up a scheduled rake task. Useful SMS is currently setup to do that locally, using the [whenever gem](https://github.com/javan/whenever). To have the deployed heroku application do this, you'll have have to setup [Heroku scheduler](https://devcenter.heroku.com/articles/scheduler) for the rake task you'd like to run.

How to use:
The home page brings you to the Dashboard, which shows you Useful SMS messages you've already setup. You can add, edit, and delete your Useful SMS messages here.

The keyword of a Useful SMS message is what Useful SMS uses to match and retrieve whatever information you input into the "body" field of the useful sms message. Whenever you text the twilio number a keyword and there's a message in Useful SMS' database matching that keyword, Useful SMS will relay the body of the useful sms message to your phone.

Useful SMS can also be configured to fetch dynamic content. Currently set up with the application is a rake task that scrapes library hours