Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"

  }
  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"

    authenticated  do
      root to: 'articles#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
 
  #新增文章的路徑
  resources :articles
  # APIs
  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        member do
          post :favorite
          post :readed 
          post :public
          post :tags, to: 'articles#tags'
          get  :tags, to: 'articles#get_tags'
        end   
      end
    end
  end
end
