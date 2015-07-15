Rails.application.routes.draw do
  get 'home/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :stars

  resources :users

  resources :posts

  resources :channels

  root "home#index"

  get "chartkick_graph_options" => "posts#chartkick_graph_options"
  get "chart_data" => "posts#chart_data"
  get "perweekday_chart_data" => "posts#perweekday_chart_data"
  get "peruser_chart_data" => "posts#peruser_chart_data"

  get "perchannel_chart_data" => "posts#perchannel_chart_data"
  get "peruser_weekday_chart_data" => "posts#peruser_weekday_chart_data"
  get "perchannel_weekday_chart_data" => "posts#perchannel_weekday_chart_data"

  get "perhour_chart_data" => "posts#perhour_chart_data"
  get "perhour_user_chart_data" => "posts#perhour_user_chart_data"
  get "perhour_channel_chart_data" => "posts#perhour_channel_chart_data"

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
