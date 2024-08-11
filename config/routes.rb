Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    delete "users/guest_sign_out", to: "users/sessions#guest_sign_out"
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
    }

# パブリックの反映
scope module: :public do
    root to: "homes#top"
    get '/top' => 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about
     resources :post_images, only: [:new, :create, :index, :show, :destroy] do
     resource :favorites, only: [:create, :destroy]
     resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update]
    resources :posts, only: [:index, :new, :create, :destroy, :edit, :update] do
    resources :comments, only: [:create, :destroy, :show]
      resource :favorites, only: [:create, :destroy]
      member do
        delete '', action: :destroy, as: 'destroy_post'
      end
    end
     get '/posts/:id', to: 'posts#show', as: 'show_post'
  end


  get "/search", to: "searches#search"

  resources :users, only: [:index, :show, :edit, :update]
  resources :posts do
  get :tags, on: :collection
  end

  delete 'posts/:id', to: 'posts#destroy', as: 'destroy_post'



end



#   get 'posts/:id' => 'posts#show', as: 'show_post'
#   delete 'posts/:id' => 'posts#destroy', as: 'destroy_post'
#   resources :users, only: [:index, :show, :edit, :update]

# resources :posts do
# get :tags, on: :collection
# end

  # get 'comments/index'
  # get 'favorites/index'
  # get 'favorites/show'
  # get 'post/new', to: 'posts#new', as: 'post_new'
  # get 'post/index', to: 'posts#index', as: 'post_index'
  # get 'post/show'

  # resources :post_image, only: [:edit, :update, :show, :index, :create]
  # # resources :posts, controller: 'posts', only: [:index, :new, :create, :destroy, :edit, :update] do
  # resources :comments, only: [:create, :destroy, :show]
  # resource :favorites, only: [:create, :destroy]
  #   member do
  #     delete '', action: :destroy, as: 'destroy_post'
  #   end
  # end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


