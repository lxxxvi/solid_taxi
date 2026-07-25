SolidTaxi::Engine.routes.draw do
  namespace :solid_queue do
    resources :recurring_tasks, only: [:index, :show] do
      resources :executions, only: [:index], module: :recurring_tasks
    end
  end

  root to: "solid_queue/recurring_tasks#index"
end
