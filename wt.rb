# -*- coding: utf-8 -*-
require 'oauth'
require 'twitter'
require 'yaml'

#$KCODE = 'UTF8' if RUBY_VERSION < '1.9'

CONSUMERKEY = "EkZzmg9e1urB2pdMusxuQ"
CONSUMERSECRET = "LbYynipCQq8nXoU0yzWhoIgQl6ykr2zjufoe4PkKAc"

if !File.file?('wktw_acc_tok.yml')
  consumer = OAuth::Consumer.new(CONSUMERKEY, CONSUMERSECRET, :site => "http://twitter.com")
  request_token = consumer.get_request_token
  puts 'Please go to web site below URL'
  puts '=> #{request_token.authorize_url}'
  
  print "input PIN: "
  oauth_verifier = STDIN.gets
  oauth_verifier.chomp!
  access_token = request_token.get_access_token(:oauth_verifier => oauth_verifier)
  token = access_token.token
  secret = access_token.secret
  acc_token = {'AccessToken' => token, 'AccessTokenSecret' => secret}
  YAML.dump({'AccessToken' => token, 'AccessTokenSecret' => secret}, File.open('wktw_acc_tok.yml', 'w'))
else
  acc_token = YAML.load(File.open('wktw_acc_tok.yml', 'r'))
end

Twitter.configure do |config|
	config.consumer_key = CONSUMERKEY
	config.consumer_secret = CONSUMERSECRET
	config.oauth_token = acc_token['AccessToken']
	config.oauth_token_secret = acc_token['AccessTokenSecret']
end

if (command = ARGV[0].dup) == nil
  STDERR.puts "USAGE:\n$ ruby wt.rb hoge"
  exit 
end
command.chomp!
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

