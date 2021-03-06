Jazzdoit::Application.routes.draw do
  resources :users do
    collection do
      get 'signup'  => 'users#signup_new'
      post 'signup' => 'users#signup_create'
    end
  end

  root 'sessions#new'

  resources :sessions, only: [:new, :create, :destroy]
  match '/login',  to: 'sessions#new',         via: 'get'
  match '/logout', to: 'sessions#destroy',     via: 'delete'

  get    'user/:id' => 'users#todo_list',                             as: "user_todo_list"
  delete 'user/:id/destroy_done_items' => 'users#destroy_done_items', as: "user_destroy_done_items"

  resources :list_items, only: [:create, :destroy]
  match '/list_items/:id',              to: 'list_items#update',      via: ['post', 'patch']
  match '/list_items/:id/move_lower',   to: 'list_items#move_lower',  via: ['post', 'patch'], as: "list_item_move_lower"
  match '/list_items/:id/move_higher',  to: 'list_items#move_higher', via: ['post', 'patch'], as: "list_item_move_higher"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
