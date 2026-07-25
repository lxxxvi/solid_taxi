class BatchSuccessJob < ApplicationJob
  def perform
    Rails.logger.info "All #{batch.completed_jobs} jobs worked!"
  end
end
