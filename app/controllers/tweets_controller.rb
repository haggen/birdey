class TweetsController < ApplicationController

  layout false
  respond_to :html, :text, :json, :js

  def last
    @callback = params.fetch(:callback, 'fn')
    @username = params[:username]

    @tweet = Tweet.by(@username)

    Keen.publish('fetch', 
      :username => @username, 
      :protocol => request.protocol, 
      :referer  => request.referer, 
      :format   => request.format.symbol)

    respond_with @tweet
  end
end
