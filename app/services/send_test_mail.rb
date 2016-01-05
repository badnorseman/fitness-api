# This sends email via HTTP
# require "rest-client"
class SendTestMail
  def initialize(text:)
    @api_key = "key-9f8dbad481f1881a3ee0bf487fd29e41"
    @domain = "sandbox8f3bf9e059a645f7a165788935e78076.mailgun.org"
    @text = text
  end

  def call
    RestClient.post "https://api:#{@api_key}@api.mailgun.net/v3/#{@domain}/messages",
    :from => "Test User <from@#{@domain}",
    :to => "to@#{@domain}",
    :subject => "This is subject",
    :text => "This is text body #{@text}"
  end
end
