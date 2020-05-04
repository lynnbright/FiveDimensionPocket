Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"

  }
  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"

    authenticated  do
      root to: 'welcome#index'
    end

<<<<<<< HEAD
    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
 
=======
  #新增文章的路徑
  resources :article

>>>>>>> issue #34 HTTParty install + 打 API + 將取回的資料存入資料庫 WIP
end
