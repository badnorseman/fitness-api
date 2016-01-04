# This sends email via HTTP
# require "rest-client"
class SendTestMail
  def initialize(text:)
    @text = text
  end

  def call
    API_KEY = "key-9f8dbad481f1881a3ee0bf487fd29e41"
    DOMAIN = "sandbox8f3bf9e059a645f7a165788935e78076.mailgun.org"
    API_URL = "https://api:#{API_KEY}@api.mailgun.net/v3/#{DOMAIN}"

    RestClient.post API_URL+"/messages",
    :from => "Test User <from@#{DOMAIN}",
    :to => "to@#{DOMAIN}",
    :subject => "This is subject",
    :text => "This is text body #{@text}"
  end
end
