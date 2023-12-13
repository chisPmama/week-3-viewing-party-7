Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/dashboard/:id/movies', to: 'movies#index', as: 'movies'
  get '/dashboard/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  get '/dashboard/:id', to: 'users#show', as: :dashboard

  get '/dashboard/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/dashboard/:user_id/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'
end
