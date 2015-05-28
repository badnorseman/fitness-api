Rails.application.routes.draw do
  # The priority is based upon order of creation: first created has highest priority.
  # See how all your routes lay out with rake routes. Read more: http://guides.rubyonrails.org/routing.html

  namespace :api do
    get "/auth/:provider/callback", to: "sessions#create", as: "login"
    get "/auth/logout", to: "sessions#destroy", as: "logout"

    resources :availabilities, except: [:new, :edit]
    resources :bookings, except: [:new, :edit] do
      post "confirm", to: "bookings#confirm", as: "confirm"
    end
    resources :bookings, except: [:new, :edit]
    resources :coaches, only: [:index] do
      get "schedule", to: "coaches#schedule", as: "schedule"
    end
    resources :exercise_plans, except: [:new, :edit]
    resources :exercise_plan_logs, except: [:new, :edit]
    resources :exercise_sessions, except: [:index, :new, :edit]
    resources :exercise_session_logs, except: [:index, :new, :edit]
    resources :exercise_sets, except: [:index, :new, :edit]
    resources :exercise_set_logs, except: [:index, :new, :edit]
    resources :exercises, except: [:index, :new, :edit]
    resources :exercise_logs, except: [:index, :new, :edit]
    resources :exercise_descriptions, except: [:new, :edit]
    resources :habit_descriptions, except: [:new, :edit]
    resources :habit_logs, except: [:new, :edit]
    resources :habits, except: [:new, :edit]
    resources :payment_plans, except: [:new, :edit]
    resources :payments, except: [:new, :edit]
    resources :roles, except: [:new, :edit]
    resources :tags, except: [:new, :edit]
    resources :users, only: [:index, :show] do
      resources :products, except: [:new, :edit]
    end

    get "users/:id/location", to: "locations#show", as: "user_location"
    post "users/:id/location", to: "locations#create", as: "create_user_location"
    put "users/:id/location", to: "locations#update", as: "update_user_location"
  end

  root to: "welcome#index"
end
