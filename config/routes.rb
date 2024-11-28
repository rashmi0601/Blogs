Rails.application.routes.draw do
  devise_for :users

  # Authenticated user routes
  authenticated :user do
    root 'pages#dashboard', as: :authenticated_root
  end

  # Public landing page
  root 'pages#home'
end
