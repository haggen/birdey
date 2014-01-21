require 'iron_cache'

class Tweet # < ActiveRecord::Base
  def self.by(username)
    iron = IronCache::Client.new
    cache = iron.cache('tweets')

    tweet = cache.get(username).try(:value)

    unless tweet 
      twitter = Twitter::REST::Client.new do |config|
        config.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      end

      tweet = twitter.user_timeline(username, count: 1).last.text
      cache.put(username, tweet, expires_in: 1.hour)
    end

    ranking = iron.cache('ranking')
    keys = ranking.get('_keys').value

    if keys
      keys.split(',').push(username).uniq!.join(',')
    else
      keys = username
    end

    ranking.put('_keys', keys)

    ranking.increment(username, 1)

    tweet
  end
end
