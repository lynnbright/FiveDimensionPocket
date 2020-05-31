Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get 'users/sign_out', to:  "users/sessions#destroy"

    authenticated  do
      root to: 'articles#index'
    end

    unauthenticated do
      root to: 'welcome#index', as: 'unauthenticated_root'
    end
  end  

  #新增文章、我的最愛頁面路徑
  resources :articles do
    collection do 
      get :favorites
      get :read_collection
      get :unread_collection
    end
  end

  # 圖表總表頁
  resources :charts, only: [:index]
  
  # 探索頁面
  resources :explores, only: [:index]

  # 追蹤頁面
  resources :followings, only: [:index]

  # 他人公開頁面
  resources :profiles, only: [:index]

  # 搜尋
  get "/search", to: "searches#search_articles"
  
  # 標籤個別頁
  resources :tags, only: [:show]

  # APIs
  # 內部 api 路徑
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
          post :highlight, to: 'articles#highlight'
          get  :highlight, to: 'articles#get_highlights'
          delete :highlight, to: 'articles#delete_highlight'
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

  # Extension api 路徑
  namespace :api do
    namespace :v1 do
      post 'login' => 'authentication#login'
      post 'logout' => 'authentication#logout'
    end
  end

  #Extension save 路徑
  namespace :api do
    namespace :v1 do
      post 'save_article' => 'extension#save_article'
      post 'save_tags' => 'extension#save_tags'
    end
  end
end
