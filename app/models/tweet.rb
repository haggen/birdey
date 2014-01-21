class Tweet < ActiveRecord::Base
  EXPIRY = 1.hour

  after_initialize do
    update_status if status.blank? || expired?
  end

  def expired?
    updated_at + EXPIRY <= Time.now
  end

  def update_status
    unless username.blank?
      twitter = Twitter::REST::Client.new do |config|
        config.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      end

      update(:status => twitter.user_timeline(username, count: 1).last.text, :updated_at => Time.now)
    end
  end

  def self.by(value)
    where(:username => value).first_or_create
  end
end
