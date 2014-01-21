class WelcomeController < ApplicationController
  def index
    if params[:me] == 'mario'
      iron = IronCache::Client.new
      ranking = iron.cache('ranking')
      keys = ranking.get('_keys').value

      @ranking = Array.wrap(keys).map do |key|
        [key, ranking.get(key).value]
      end
    end
  end
end
