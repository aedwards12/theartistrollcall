Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  get 'contact_form/new'
  get 'contact_form/create'
  match '/auth/:action/callback', :to => 'omniauth_callbacks', :constraints => { :action => /twitter|facebook/ }, via: [:get, :post]
  get 'welcome/search' => 'welcome#search'
  get 'about' => 'welcome#about'
  resources :video do
    get :artists, on: :member
    post :tag
  end
  resources :profiles
  resources :artists
  resources :contact_forms
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  get 'artist/:id/up_vote' => 'votes#up_vote', via: :get, as: :up_vote
  get 'artist/:id/down_vote' => 'votes#down_vote', via: :get, as: :down_vote

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
