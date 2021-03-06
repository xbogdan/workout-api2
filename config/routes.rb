Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # Sessions
      match '/signin' => 'sessions#create', via: [:post, :options]
      match '/signout' => 'sessions#destroy', via: [:delete, :options]

      # Users
      match '/signup' => 'sessions#register', via: [:post, :options]

      # Programs
      match '/programs' => 'programs#index', via: [:get, :options]
      match '/program' => 'programs#show', via: [:get, :options]
      match '/updateProgram' => 'programs#update', via: [:put, :options]
      match '/createProgram' => 'programs#create', via: [:post, :options]
      match '/deleteProgram' => 'programs#destroy', via: [:delete, :options]

      # Tracks
      match '/tracks' => 'tracks#index', via: [:get, :options]
      match '/track' => 'tracks#show', via: [:get, :options]
      match '/updateTrack' => 'tracks#update', via: [:put, :options]
      match '/createTrack' => 'tracks#create', via: [:post, :options]
      match '/deleteTrack' => 'tracks#destroy', via: [:delete, :options]

      match '/createTrackDay' => 'track_days#create', via: [:post, :options]
      match '/updateTrackDay' => 'track_days#update', via: [:put, :options]
      match '/deleteTrackDay' => 'track_days#destroy', via: [:delete, :options]

      match '/createTrackDayExercise' => 'track_day_exercises#create', via: [:post, :options]
      match '/updateTrackDayExercise' => 'track_day_exercises#update', via: [:put, :options]
      match '/deleteTrackDayExercise' => 'track_day_exercises#destroy', via: [:delete, :options]

      match '/createTrackDayExerciseSet' => 'track_day_exercise_sets#create', via: [:post, :options]
      match '/updateTrackDayExerciseSet' => 'track_day_exercise_sets#update', via: [:put, :options]
      match '/deleteTrackDayExerciseSet' => 'track_day_exercise_sets#destroy', via: [:delete, :options]

      # Exercises
      match '/exercises' => 'exercises#index', via: [:get, :options]
      match '/createExercise' => 'exercises#create', via: [:post, :options]
      match '/deleteExercise' => 'exercises#destroy', via: [:delete, :options]

      # Muscle Groups
      match '/muscleGroups' => 'muscle_groups#index', via: [:get, :options]
      match '/createMuscleGroup' => 'muscle_groups#create', via: [:post, :options]

      # Muscle Groups
      match '/exerciseMuscleGroups' => 'exercise_muscle_groups#index', via: [:get, :options]
    end
  end
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
