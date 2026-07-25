class SemaphoryJob < ApplicationJob
  limits_concurrency to: 1, key: :semaphory_job

  def perform
    sleep 115
  end
end
