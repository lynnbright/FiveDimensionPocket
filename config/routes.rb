Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"

  }
  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"

    authenticated  do
      root to: 'article#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
 
  #新增文章的路徑
  resources :article
  # get 'api/:user_id/articles', to: 'api/articles#index', as: :api_articles_index, defaults: { s: :json}
  # # namespace :api do
  # #   resources :users, only: [:show] do
  # #     resources :articles, only: [:index, :show]
  # #   end
  # # end
end
