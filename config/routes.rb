Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/show'
  get 'favorites/index'
  get 'favorites/show'
  get 'post/new', to: 'posts#new', as: 'post_new'
  get 'post/index', to: 'posts#index', as: 'post_index'
  get 'post/show'
    devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
    }
  root to: "homes#top"
  get '/top' => 'homes#top'
  get 'homes/about' => 'homes#about'

  resources :post_image, only: [:edit, :update, :show, :index, :create]

   resources :posts, controller: 'posts', only: [:index, :new, :create, :destroy, :edit, :update] do
    member do
      delete '', action: :destroy, as: 'destroy_post'
    end
  end
    get 'posts/:id' => 'posts#show', as: 'show_post'
  delete 'posts/:id' => 'posts#destroy', as: 'destroy_post'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
