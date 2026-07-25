class CrashJob < ApplicationJob
  def perform(seconds = 1)
    sleep seconds

    raise RuntimeError, "CrashJob crashed after #{seconds} second(s)"
  end
end
