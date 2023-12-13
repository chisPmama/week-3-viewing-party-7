Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/dashboard/movies', to: 'movies#index', as: 'movies'
  get '/dashboard/movies/:id', to: 'movies#show', as: 'movie'

  get '/movies/:id', to: 'movies#visit_show', as: 'movie_visit'

  get '/dashboard', to: 'users#show', as: :dashboard

  get '/dashboard/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new', as: 'viewing_party'
  post '/dashboard/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'
end
