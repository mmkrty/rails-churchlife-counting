Rails.application.routes.draw do
  get 'reports/weekly_stats'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "pages#dashboard", as: 'dashboard'
  get 'weeklyreports/:week_number', to: 'reports#weekly_stats', as: :weekly_stats

  # Defines the root path route ("/")
  # root "articles#index"
  resources :lords_days
  resources :prayer_meetings
  resources :small_groups
end
