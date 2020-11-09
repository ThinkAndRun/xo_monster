Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  namespace :client_api do
    namespace :v1 do
      post 'refresh', controller: :refresh, action: :create
      post 'signin', controller: :signin, action: :create
      post 'signup', controller: :signup, action: :create
      delete 'signin', controller: :signin, action: :destroy

      resources :friends, only: [:index] do
        collection do
          # post :activate
        end
      end

      resources :users, only: [] do
        collection do
          get :me
        end
      end

      resources :xo_sessions, only: [:index, :create, :show] do
        collection do
        #
        end
      end
    end
  end

  # Admin app could be here
  # get '/admin', to: 'welcome#admin'
  # get '/admin/*path', to: 'welcome#admin', format: false

  root to: 'welcome#client'
  get '/*path', to: 'welcome#client', format: false
end
