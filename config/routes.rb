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

  # 圖表
  get "/charts", to: "charts#index"
  # get 'api/:user_id/articles', to: 'api/articles#index', as: :api_articles_index, defaults: { s: :json}
  # # namespace :api do
  # #   resources :users, only: [:show] do
  # #     resources :articles, only: [:index, :show]
  # #   end
  # # end
  
  #探索頁面路徑
  resources :explores, only: [:index]
  #追蹤頁面路徑
  resources :followers, only: [:index]
  #各使用者的頁面


  # 探索
  get "/explores", to: "explores#index"

  # APIs
  #內部 api 路徑
  #api
  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        member do
          post :favorite
          post :read 
          post :publish
          post :tags, to: 'articles#tags'
          get  :tags, to: 'articles#get_tags'
          post :create_speech
        end   
      end
      resource :charts, only: [] do
        member do                  
          get :tag
          get :read
        end  
      end 
      resources :users, only: [] do
        member do                  
          post :follow
        end  
      end     
    end
  end

  #api2
  namespace :api do
    namespace :v1 do
      post 'login' => 'authentication#login'
      post 'logout' => 'authentication#logout'
    end
  end
end
