Rails.application.routes.draw do
  devise_for :users 

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#index"
end
