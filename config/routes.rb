PodcastNetwork::Application.routes.draw do
  devise_for :admins

  match 'episodes',                :to => 'episodes#index', :as => 'episodes'
  match 'podcasts',                :to => 'podcasts#index', :as => 'podcasts'

  match ':podcast_shortname',      :to => 'podcasts#show', :as => 'podcast_show'
  match ':podcast_shortname/edit', :to => 'podcasts#edit', :as => 'podcast_edit'

  match ':podcast_shortname/feed', :to => 'podcasts#show', :as => 'podcast_feed', :format => 'rss'
  match ':podcast_shortname/rss',  :to => 'podcasts#show', :as => 'podcast_feed', :format => 'rss'

  match ':podcast_shortname/:episode_number',      :to => 'episodes#show', :as => 'episode_show'
  match ':podcast_shortname/:episode_number/edit', :to => 'episodes#edit', :as => 'episode_edit'


  # resources :episodes, :podcasts

  root :to => 'podcasts#index'

  # match 'logout', :to => 'sessions#destroy', :as => "logout"


  # match ':podcast_shortname' => 'podcasts#show'
  # match ':podcast_shortname/:episode_number' => 'episodes#show'


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
