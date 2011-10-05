require 'rubygems'
require 'oauth'
require 'twitter'

CONSUMERKEY = "EkZzmg9e1urB2pdMusxuQ"
CONSUMERSECRET = "LbYynipCQq8nXoU0yzWhoIgQl6ykr2zjufoe4PkKAc"

consumer = OAuth::Consumer.new(CONSUMERKEY, CONSUMERSECRET, :site => "http://api.twitter.com")

oauth_verifier = "6475586"
access_token = consumer.get_access_token
access_tok = access_token.token
access_secret = access_token.secret

#access_tok = "20989679-vRVegGOaP6sTC1C8oLdZG4vwDI3xvTYk79rHd6Km9"
#access_secret = "irhW5hVeuXMkhdYlPaE6DrsYi0fu3lUM8w6cNMaGg"

Twitter.configure do |config|
	config.consumer_key = CONSUMERKEY
	config.consumer_secret = CONSUMERSECRET
	config.oauth_token = access_tok
	config.oauth_token_secret = access_secret
end

$KCONF = "UTF-8"
command = ARGV.shift.chomp
if (command == "timeline" or command == "tl")
	#puts "status id\t\tscreen name\ttweet"
	if (ARGV.shift != nil)
		Twitter.home_timeline.each do |tl|
			puts "%s\t%s\t%s"%[tl.id, tl.user.screen_name, tl.text]
		end
	else
		Twitter.friends_timeline.each do |tl|
			puts "%s\t%s\t%s"%[tl.id, tl.user.screen_name, tl.text]
		end
	end
elsif (command == "tw")
	Twitter.update(ARGV.shift.chomp)
elsif (command == "retweet" or command == "rt")
	Twitter.retweet(ARGV.shift.chomp)
else
	Twitter.update(command)
end

