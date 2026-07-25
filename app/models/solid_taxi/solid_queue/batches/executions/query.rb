class SolidTaxi::SolidQueue::Batches::Executions::Query < SolidTaxi::Query
  ORDER_BY = { "solid_queue_jobs.created_at": :desc }

  private

  def find_scope
    @scope = base_scope.select(%(solid_queue_batch_executions.*, solid_queue_jobs.*, #{SolidTaxi::SolidQueue::Job::CUSTOM__STATUS_CASE_WHEN_BLOCK} AS custom__status))

    add_filter(:exact, "solid_queue_jobs.id", query_form.job__id)
    add_filter(:like, "solid_queue_jobs.queue_name", query_form.job__queue_name)
    add_filter(:like, "solid_queue_jobs.class_name", query_form.job__class_name)
    add_filter(:like, "solid_queue_jobs.arguments", query_form.job__arguments)
    add_filter(:number_from, "solid_queue_jobs.priority", query_form.job__priority_from)
    add_filter(:number_to, "solid_queue_jobs.priority", query_form.job__priority_to)
    add_filter(:like, "solid_queue_jobs.active_job_id", query_form.job__active_job_id)
    add_filter(:from_time, "solid_queue_jobs.scheduled_at", query_form.job__scheduled_at_from)
    add_filter(:to_time, "solid_queue_jobs.scheduled_at", query_form.job__scheduled_at_to)
    add_filter(:from_time, "solid_queue_jobs.finished_at", query_form.job__finished_at_from)
    add_filter(:to_time, "solid_queue_jobs.finished_at", query_form.job__finished_at_to)
    add_filter(:like, "solid_queue_jobs.concurrency_key", query_form.job__concurrency_key)
    add_filter(:like, SolidTaxi::SolidQueue::Job::CUSTOM__STATUS_CASE_WHEN_BLOCK, query_form.job__custom__status)

    @scope
  end

  def base_scope
    page
      .batch
      .batch_executions
      .joins(:job)
      .includes(:job)
      .left_outer_joins(job: [ :scheduled_execution, :ready_execution, :claimed_execution, :blocked_execution, :failed_execution ])
  end
end
