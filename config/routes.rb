Birdey::Application.routes.draw do
  
  root 'welcome#index'

  get '/:username' => 'tweets#last'

end
