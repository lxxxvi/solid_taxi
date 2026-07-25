class BatchFinishJob < ApplicationJob
  def perform
    Rails.logger.info "Finished all #{batch.total_jobs} jobs"
  end
end
