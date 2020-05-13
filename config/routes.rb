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

  # APIs
  #內部 api 路徑
  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        member do
          post :favorite
          post :readed 
          post :public
          post :tags, to: 'articles#tags'
          get  :tags, to: 'articles#get_tags'
          post :create_speech
        end   
      end
      resource :charts, only: [] do
        member do                  
          get :tag
          get :readed
        end  
      end     
    end
  end

end
