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

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_root'
    end
  end
 
end
