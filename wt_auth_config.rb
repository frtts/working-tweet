require 'rubygems'

CONSUMERKEY = "EkZzmg9e1urB2pdMusxuQ"
CONSUMERSECRET = "LbYynipCQq8nXoU0yzWhoIgQl6ykr2zjufoe4PkKAc"

# request_tokenとかaccess_tokenとかがない場合
consumer=  OAuth::Consumer.new(CONSUMERKEY, CONSUMERSECRET, :site => "http://twitter.com")

request_token = consumer.get_request_token
request_token.authorize_url

# 許可したらなんか番号を入れるやつ
oauth_verifier = "6475586"
access_token = request_token.get_access_token(:oauth_verifier => oauth_verifier)
access_tok = access_token.token
access_secret = access_token.secret

#Twitter.methods.sort
Twitter.configure do |config|
	config.consumer_key = CONSUMERKEY
	config.consumer_secret = CONSUMERSECRET
	config.oauth_token = access_token.token
	config.oauth_token_secret = access_token.secret
end

Twitter.user
$KCONF = "UTF-8"
usr = Twitter.user
usr.keys
usr[:profile_sidebar_fill_color]
usr[:name]
puts usr[:name]
usr.keys.sort
Twitter.update("アホなクライアントからツイートだぜ")
