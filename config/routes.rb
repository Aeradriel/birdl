Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, skip: [:sessions],
             controllers: {
               registrations: 'users/registrations',
               omniauth_callbacks: 'omniauth_callbacks'
             }

  as :user do
    get '/login' => 'devise/sessions#new', as: :new_user_session
    post '/login' => 'devise/sessions#create', as: :user_session
    delete '/logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :events do
    get '/' => 'events#search'
    post '/' => 'events#search_result', as: :search
    get '/new' => 'events#new', as: :new_event
    post '/new' => 'events#create'
    get '/groupevents' => 'group_event#index', as: :group_events
    get '/groupevents/:event_id' => 'group_event#show', as: :group_event
    get '/onlinechat/' => 'online_chat#index', as: :online_chat
    get '/facestofaces' => 'face_to_face#index', as: :faces_to_faces
    get '/facestofaces/:event_id' => 'face_to_face#show', as: :face_to_face
  end

  namespace :admin do
    get '/' => 'admin#index'

    resource :users do
      get '/' => 'users#users'
      get '/new' => 'users#new'
      post '/create' => 'users#create'
      get '/:user_id/edit' => 'users#edit'
      post '/:user_id/edit' => 'users#update'
      delete '/:user_id/delete' => 'users#delete'
    end

    resource :countries do
      get '/' => 'countries#countries'
      get '/new' => 'countries#new'
      post '/create' => 'countries#create'
      get '/:country_id/edit' => 'countries#edit'
      post '/:country_id/edit' => 'countries#update'
      delete '/:country_id/delete' => 'countries#delete'
    end
  end

  get '/users/:user_id/rate' => 'users/users#rate', as: :user_rating
  get '/check_birthdate' => 'information_checker#validate_birthdate',
      as: :birthdate_validation_path
  post '/check_birthdate' => 'information_checker#check_birthdate'
  get '/change_locale/:key' => 'application#change_locale'
  post '/api/check_email/:email' => 'api#check_email',
       constraints: { email: /[0-z\.]+/ }

  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions
  # automatically):
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
  #     # Directs /products/* to Admin::ProductsController
  #     # (app/controllers/products_controller.rb)
  #     resources :products
  #   end
end
