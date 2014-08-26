Rails.application.routes.draw do

  get 'welcome/index'

 get "log_out" => "sessions#destroy", :as => "log_out"
 get "log_in" => "sessions#new", :as => "log_in"
 get "sign_up" => "users#new", :as => "sign_up"
 root 'welcome#index'

# get "users" => "users#show", :as => "users_profile"
 get 'users/imgcan' => "users#image_detail", :as => "image_detail"
 
  #get "profile/tags" => "tags#show", :as => "user_tag_path"
 #resources :tags
 resources :users do
  resources :tags
 end
 resources :sessions


 get 'user/:id/edit_preferences' => 'users#edit_preferences', :as => 'edit_user_preferences'

 get '*path' => redirect('/')



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
