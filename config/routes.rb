Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get 'users/sign_out' => "users/sessions#destroy"

    authenticated  do
      root to: 'articles#index'
    end

    unauthenticated do
      root to: 'users/sessions#new', as: 'unauthenticated_root'
    end
  end  

   #新增文章、我的最愛頁面路徑
  resources :articles do
    collection do 
      get :favorites
    end
  end

  # 圖表
  get "/charts", to: "charts#index"
  
  #探索頁面
  resources :explores, only: [:index]

  #追蹤頁面
  resources :followers, only: [:index]

  # 搜尋
  get "/search", to: "searches#search_articles"
  resources :tags, only: [:show]


  #內部 api 路徑
  namespace :api do
    namespace :v1 do
      resources :tags, only: [:index] do
      end     
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

  #Extension api 路徑
  namespace :api do
    namespace :v1 do
      post 'login' => 'authentication#login'
      post 'logout' => 'authentication#logout'
    end
  end
end
