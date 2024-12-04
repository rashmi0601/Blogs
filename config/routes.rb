Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'blog_posts#dashboard', as: :authenticated_root
  end

  root 'pages#home'

  resources :blog_posts do
    member do
      patch :approve
      patch :reject
      delete :delete_blog_post
    end
  end
end
