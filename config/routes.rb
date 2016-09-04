Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'site#home'

  post '/attack' => 'attack#attack'
end
