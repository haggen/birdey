require 'iron_cache'

class Tweet # < ActiveRecord::Base
  def self.by(username)
    cache = IronCache::Client.new
    cache = cache.cache('tweets')

    tweet = cache.get(username).try(:value)

    unless tweet 
      twitter = Twitter::REST::Client.new do |config|
        config.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      end

      tweet = twitter.user_timeline(username, count: 1).last.text
      cache.put(username, tweet, expires_in: 1.hour)
    end

    tweet
  end
end
