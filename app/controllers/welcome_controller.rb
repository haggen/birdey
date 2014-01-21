class WelcomeController < ApplicationController
  def index
    if params[:me] == 'mario'
      iron = IronCache::Client.new
      ranking = iron.cache('ranking')
      keys = ranking.get('_keys').try(:value)

      @ranking = Array.wrap(keys.split(',')).map do |key|
        [key, ranking.get(key).try(:value) || 1]
      end
    end
  end
end
