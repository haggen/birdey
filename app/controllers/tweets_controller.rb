class TweetsController < ApplicationController

  layout false
  respond_to :html, :text, :json, :js

  def last
    @callback = params[:callback]
    @username = params[:username]

    @tweet = Tweet.by(@username)

    respond_with @tweet
  end
end
