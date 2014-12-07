Rails.application.routes.draw do

  root 'stories#index'

  get 'stories/' => 'stories#index'

  get 'stories/:id' => 'stories#show', as: 'story'

end
