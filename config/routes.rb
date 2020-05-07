Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root "welcome#index"

  #新增文章的路徑
  resources :article
  # get 'api/:user_id/articles', to: 'api/articles#index', as: :api_articles_index, defaults: { s: :json}
  # # namespace :api do
  # #   resources :users, only: [:show] do
  # #     resources :articles, only: [:index, :show]
  # #   end
  # # end
end
