class SleepyJob < ApplicationJob
  def perform(seconds = 45)
    sleep seconds
  end
end
