class BatchFailureJob < ApplicationJob
  def perform
    Rails.logger.info "#{batch.failed_jobs} jobs failed, sorry!"
  end
end
