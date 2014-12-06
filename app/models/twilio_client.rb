class TwilioClient
  SID = "AC209f7c1a9e533baccbe2b182277b4953"
  TOKEN = "268e317d14042838279b53112e67157b"
  TWILIO_NUMBER = "+16464801969"

  def initialize
    @client = Twilio::REST::Client.new(SID, TOKEN)
    @from = TWILIO_NUMBER
    @to = "9179210016" 
  end

  def message_to_admin
    "This is your dashboard notification system. There are #{NewEvent.last.count} new Pulsd events today."
  end
 
  def send_text
    @client.account.sms.messages.create(
      :from => TWILIO_NUMBER,
      :to => "9179210016",
      :body => message_to_admin
      )
  end
end
