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
  # get 'api/:user_id/articles', to: 'api/articles#index', as: :api_articles_index, defaults: { s: :json}
  # # namespace :api do
  # #   resources :users, only: [:show] do
  # #     resources :articles, only: [:index, :show]
  # #   end
  # # end


  namespace :api do
    namespace :v1 do
      # only，只做出想要的網址皮，其他延伸的都不要
      resources :articles, only: [] do
        member do
          post :favorite
          post :readed 
          post :public
          post :tags
        end   
      end
    end
  end
end
