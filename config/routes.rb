Coursehub::Application.routes.draw do
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  devise_for :users

  match '/users/coursems' => 'users#coursems'

  resources :users
  resources :resources
  resources :events

  match '/events/recentevent/:id' => 'events#recentevent'

  match '/profile' => 'users#edit'
  match '/users/coursems' => 'users#coursems'
  match '/users/subscribe' => 'users#subscribe'
  match '/users/unsubscribe' => 'users#unsubscribe'
  match '/users/addFavorite' => 'users#addFavorite'
  match '/users/deleteFavorite' => 'users#deleteFavorite'

  match 'courses/resources' => 'courses#resources'
  match '/courses/department' => 'courses#getDepartment'
  match '/courses' => 'courses#index'
  match '/courses/check' => 'courses#checkSubscribed'
  match '/coursem/create' => 'coursem#create'


  match '/resources/addComment' => 'resources#addComment'
  match '/resources/type' => 'resources#getResourcesType'
  match '/resources/check' => 'resources#checkFavorite'

  authenticated :user do
    root :to => "users#home"
  end
  root :to => redirect("/users/sign_in")

  resources :coursem
  #resources :courses

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
