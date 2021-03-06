Rails.application.routes.draw do
  resources :employments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  post 'welcome', to: 'welcome#set_current_year'

  get 'tenants/roles', to: 'welcome#roles'
  post 'tenants/roles', to: 'welcome#set_role'

  resources :customers do
    resources :records
  end

  resources :books do
    resources :fees do
      resources :fee_records

      get 'monthly_report', to: 'fees#show_monthly_report'

      get 'daily_trend', to: 'fees#show_daily_trend'
    end

    get 'monthly_report', to: 'books#show_monthly_report'
  end

  #get '/tenants/sign_in', to: 'devise/sessions#new'

  #devise_for :tenants, :controllers => {:registrations => "registrations"}
  devise_for :tenants

  # Example of regular route:
  #  get 'products/:id' => 'catalog#view'

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
