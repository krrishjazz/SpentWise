Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  resources :posts
  root to: 'pages#home'

  resources :contacts
  resources :employees
  resources :reports

  devise_for :users



  post 'authenticate', to: 'authentication#authenticate'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :employees do
      resources :expenses do
        member do
          get :get_comment
          post :add_comment
        end 
      end
    resources :reports do
      resources :expenses do
      end
      member do
        get :get_expense
        post :add_expense
        get :get_comment
        post :add_comment
        patch :edit_expense
        patch :edit_report
      end
    
    end
      member do
        get :get_expense
        get :get_report
        post :add_expense
        post :add_report
        patch :edit_report
      end      
  end
end
