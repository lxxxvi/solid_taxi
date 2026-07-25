SolidTaxi::Engine.routes.draw do
  namespace :solid_cable do
    resources :messages, only: [ :index ]

    root to: "messages#index"
  end

  namespace :solid_cache do
    resources :entries, only: [ :index ]

    root to: "entries#index"
  end

  namespace :solid_queue do
    resources :batches, only: [ :index, :show ] do
      resources :executions, only: [ :index ], module: :batches
    end
    resources :jobs, only: [ :index, :show ]
    resources :pauses, only: [ :index ]
    resources :processes, only: [ :index ]
    resources :semaphores, only: [ :index ]
    resources :recurring_tasks, only: [ :index, :show ] do
      resources :executions, only: [ :index ], module: :recurring_tasks
    end

    root to: "jobs#index"
  end

  root to: "welcomes#show"
end
