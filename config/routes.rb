Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/profile" => "users#index"

  # to send suggestion to follow other users
  post "/profile/suggestions" => "users#suggestions"
  post "profile/follows" =>  "users#follows"
  delete "profile/unfollows" => "users#unfollows"

  post "/stories/fetch" => "stories#index"
  post "/stories" => "stories#create"

  get "/auth" => "sessions#verify"

  
  post "/login" => "sessions#create"
  post "/signup" => "users#create"

  get "/account/:username" => "profiles#show"
  post '/account/:username' => 'profiles#create'
  put '/account/:username' => 'profiles#update'

end
