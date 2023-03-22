Rails.application.routes.draw do
  get 'reports/weekly_stats'
  devise_for :users, skip: :registrations
  resources :users, only: [:create, :index, :edit, :update, :destroy]
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "pages#dashboard", as: 'dashboard'
  get 'weeklyreports/:week_number', to: 'reports#weekly_stats', as: :weekly_stats
  get '/new_count', to: 'pages#new_count'
  get '/admin', to: 'pages#admin'

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lords_days
  resources :prayer_meetings
  resources :small_groups

  resources :reports do
    post :send_weekly_stats_email, on: :collection
  end
end
