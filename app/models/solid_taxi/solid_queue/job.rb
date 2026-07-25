class SolidTaxi::SolidQueue::Job
   CUSTOM__STATUS_CASE_WHEN_BLOCK = <<~SQL
      CASE
      WHEN solid_queue_jobs.finished_at IS NOT NULL             THEN 'finished'
      WHEN solid_queue_scheduled_executions.job_id IS NOT NULL  THEN 'scheduled'
      WHEN solid_queue_ready_executions.job_id IS NOT NULL      THEN 'ready'
      WHEN solid_queue_claimed_executions.job_id IS NOT NULL    THEN 'claimed'
      WHEN solid_queue_blocked_executions.job_id IS NOT NULL    THEN 'blocked'
      WHEN solid_queue_failed_executions.job_id IS NOT NULL     THEN 'failed'
                                                                ELSE 'unknown'
      END
  SQL
end
