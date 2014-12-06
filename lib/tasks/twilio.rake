namespace :twilio do
  desc "send new events text notification to administrator"
  task :send_text => :environment do
    twilio_text = TwilioClient.new
    if NewEvent.last
      twilio_text.send_text
    end
  end
end
