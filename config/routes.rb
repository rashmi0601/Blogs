Rails.application.routes.draw do
  devise_for :users

  # Authenticated user routes
  authenticated :user do
    root 'blog_posts#dashboard', as: :authenticated_root
  end

  # Public landing page
  root 'pages#home'

  resources :blog_posts do
    member do
      patch :approve
      patch :reject
    end
  end
end
