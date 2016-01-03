Rails.application.routes.draw do
  # The priority is based upon order of creation: first created has highest priority.
  # See how all your routes lay out with rake routes. Read more: http://guides.rubyonrails.org/routing.html

  namespace :api do
    match "/auth/:provider/callback", to: "sessions#create", via: [:get, :post]
    get "/auth/failure", to: "sessions#failure"
    get "/logout", to: "sessions#destroy"

    resources :availabilities, only: [:index, :show, :create, :update, :destroy]
    resources :bookings, only: [:index, :show, :create, :update, :destroy] do
      post "confirm", to: "bookings#confirm", as: "confirm"
    end
    resources :bookings, only: [:index, :show, :create, :update, :destroy]
    resources :coaches, only: [:index] do
      get "schedule", to: "coaches#schedule", as: "schedule"
    end
    resources :exercise_plans, only: [:index, :show, :create, :update, :destroy]
    resources :exercise_plan_logs, only: [:index, :show, :create, :update, :destroy]
    resources :exercise_sessions, only: [:show, :create, :update, :destroy]
    resources :exercise_session_logs, only: [:show, :create, :update, :destroy]
    resources :exercise_sets, only: [:show, :create, :update, :destroy]
    resources :exercise_set_logs, only: [:show, :create, :update, :destroy]
    resources :exercises, only: [:show, :create, :update, :destroy]
    resources :exercise_logs, only: [:show, :create, :update, :destroy]
    resources :exercise_descriptions, only: [:index, :show, :create, :update, :destroy]
    resources :habit_descriptions, only: [:index, :show, :create, :update, :destroy]
    resources :habit_logs, only: [:index, :show, :create, :update, :destroy]
    resources :habits, only: [:index, :show, :create, :update, :destroy]
    resources :identities, only: [:new]
    resources :payment_plans, only: [:index, :show, :create, :update, :destroy]
    resources :products, only: [:index, :show, :create, :update, :destroy]
    resources :password_resets, only: [:create, :update]
    resources :tags, only: [:index, :show, :create, :update, :destroy]
    resources :transactions, only: [:index, :show, :new, :create, :update, :destroy]
    resources :users, only: [:index, :show, :update]

    get "users/:id/location", to: "locations#show", as: "user_location"
    post "users/:id/location", to: "locations#create", as: "create_user_location"
    put "users/:id/location", to: "locations#update", as: "update_user_location"
  end
end
